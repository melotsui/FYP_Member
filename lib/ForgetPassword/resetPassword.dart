import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/ForgetPassword/forgetPassword.dart';
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

Future<ResetPassword> resetPasswordAPI(String id, String oldPw, String newPw) async {
  status = Status.loading;
  final response = await http.post(
    Uri.parse('$apiDomain/updateMemberPassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"accountID": id, "oldPassword": oldPw, "password": newPw}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    status = Status.success;
    return ResetPassword.fromJson(jsonDecode(response.body));
  } else {
    status = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("ererrererer");
    throw Exception('Invalid resetPasswordAPI');
  }
}

class ResetPassword {
  String? success;
  String? error;

  ResetPassword({this.success, this.error});

  ResetPassword.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
  }
}

class ResetPasswordPage extends StatefulWidget {
  String id;
  ResetPasswordPage({Key? key, required this.id}) : super(key: key);
  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isValid = false;
  String resetPassword = "";
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
            (Route<dynamic> route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          title: Text("Reset Password"),
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Expanded(child: Container()),
              Image(
                image: AssetImage('assets/resetpw.png'),
                fit: BoxFit.contain,
              ),
              Expanded(child: Container()),
              Container(
                // padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  initialValue: "Aa111111",
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    helperText: '',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'Reset Password',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    resetPassword = value!;
                  },
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value != null) {
                      if (!passwordValidation(value) && value.length < 8) {
                        isValid = false;
                        return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                      } else {
                        if (value.length < 8 || !passwordValidation(value)) {
                          isValid = false;
                          if (value.length < 8) {
                            return "Equal to or more than 8 letters and digits";
                          }
                          if (!passwordValidation(value)) {
                            return "Must have uppercase and lowercase and digit";
                          }
                        } else {
                          isValid = true;
                          return null;
                        }
                      }
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
                          loadingScreen(context);
                          updateAccountAPI(widget.id).then((value){
                            String pw = value.accountPassword.toString();
                            resetPasswordAPI(widget.id, pw, resetPassword).then((value){
                              if(value.error == null){
                                Future.delayed(
                                  Duration(milliseconds: 500),
                                      () {
                                    Fluttertoast.showToast(msg: "Password Reseted");
                                    print(value);
                                    print(value.success.toString());
                                    print(value.error.toString());
                                    print(resetPassword.toString());
                                    navigateToLoginPage(context);
                                  },
                                );
                              } else {
                                Fluttertoast.showToast(msg: value.error.toString());
                              }
                            });
                          });
                        } else {
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "Invalid Password.");
                        }
                        // login = 1;
                        // setState(() {});
                        // navigateToMyProfilePage(context);
                      },
                      child: status == Status.loading
                          ? Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
