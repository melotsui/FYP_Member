import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Var/natigate.dart';
import 'package:member/Var/var.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Login/login.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';

Status sendPasscodeStatus = Status.success;
Future<OneTimePasscode> sendOneTimePasscodeAPI(String email) async {
  sendPasscodeStatus = Status.loading;
  print(email);
  final response = await http.post(
    Uri.parse('$apiDomain/sendForgetPassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"email": email}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    sendPasscodeStatus = Status.success;
    return OneTimePasscode.fromJson(jsonDecode(response.body));
  } else {
    sendPasscodeStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to Send One Time Passcode');
  }
}

class OneTimePasscode {
  String? passcode;
  String? accountID;
  String? error;

  OneTimePasscode({this.passcode});

  OneTimePasscode.fromJson(Map<String, dynamic> json) {
    passcode = json['passcode'];
    accountID = json['accountID'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['passcode'] = this.passcode;
    data['accountID'] = this.accountID;
    data['error'] = this.error;
    return data;
  }
}

class ForgetPasswordPage extends StatefulWidget {
  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  SecureStorage storage = SecureStorage();
  String defaultEmail = "";
  Status readEmail = Status.loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storage.readSecureData("email").then((value) {
      readEmail = Status.success;
      setState(() {});
      if (value != null) {
        print("Emailll: " + value);
        defaultEmail = value;
        forgetEmail = defaultEmail;
        print("Emailll: " + forgetEmail);
      } else {
        defaultEmail = "";
      }
      if (forgetEmail != "") {
        if (isEmail(forgetEmail)) {
          isValid = true;
        } else {
          isValid = false;
        }
      }
    });
    print("ASDASDASD " + forgetEmail.toString());
  }

  bool isValid = false;
  String forgetEmail = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Forget Password"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: readEmail == Status.loading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  Image(
                    image: AssetImage('assets/ForgetPasswordImage.png'),
                    fit: BoxFit.contain,
                  ),
                  Container(
                    // padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      initialValue: defaultEmail,
                      autofocus: true,
                      style: TextStyle(fontSize: 20),
                      scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        helperText: '',
                        // icon: Icon(Icons.person),
                        hintText: '',
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? value) {
                        forgetEmail = value!;
                      },
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (isEmail(value!)) {
                          isValid = true;
                          return null;
                        } else {
                          isValid = false;
                          return "Invalid Email Address";
                        }
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            if (isValid) {
                              status = Status.loading;
                              setState(() {});
                              sendOneTimePasscodeAPI(forgetEmail).then((value) {
                                status = Status.success;
                                print(value.passcode.toString());
                                if (value.error == null) {
                                  Fluttertoast.showToast(
                                    msg: "Password will send to you email.",
                                  );
                                  String id = value.accountID.toString();
                                  String pcode = value.passcode.toString();
                                  print(pcode);
                                  sendPasscodeStatus = Status.success;
                                  setState(() {});
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => InputOneTimePasscodePage()));
                                  screenLock(
                                    context: context,
                                    title:
                                        HeadingTitle(text: "One Time Passcode"),
                                    digits: 6,
                                    correctString: pcode,
                                    didUnlocked: () {
                                      loadingScreen(context);
                                      print(pcode);
                                      Future.delayed(
                                        Duration(milliseconds: 500),
                                        () {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please reset your password");
                                          navigateToResetPasswordPage(
                                              context, id);
                                        },
                                      );
                                    },
                                    didError: (didError) {
                                      if (didError > 0) {
                                        Fluttertoast.showToast(
                                          msg: "Invalid Passcode",
                                        );
                                        if (didError == 5) {}
                                      }
                                    },
                                    cancelButton: GestureDetector(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: Text(
                                              "Are you sure you want to leave the forget password page?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: Text('No'),
                                              ),
                                              TextButton(
                                                child: Text('Yes'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginPage()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: value.error.toString(),
                                  );
                                }
                              });
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (context) => LoginPage()),
                              //     (Route<dynamic> route) => false);
                            } else {
                              Fluttertoast.showToast(msg: "Invalid Email.");
                            }
                            // login = 1;
                            // setState(() {});
                            // navigateToMyProfilePage(context);
                          },
                          child: sendPasscodeStatus == Status.loading
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'SEND ONE TIME PASSCODE',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Text("")),
                ],
              ),
            ),
    );
  }
}
