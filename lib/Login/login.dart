import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Login/register.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Product/productList.dart';
import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';
import '../Account/profile.dart';

Future<Account> loginAPI(String email, pwd) async {
  status = Status.loading;
  final response = await http.post(
    Uri.parse('$apiDomain/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"email": email, "password": pwd}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    status = Status.success;
    return Account.fromJson(jsonDecode(response.body));
  } else {
    status = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to login');
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  SecureStorage storage = SecureStorage();
  Status readEmail = Status.loading;
  Status readPw = Status.loading;
  List<bool> isValid = [];
  String loginPassword = "";
  String loginEmail = "";
  String defaultPassword = "";
  String defaultEmail = "";
  @override
  void initState() {
    // TODO: implement initState

    isValid = [false, false];

    storage.readSecureData("email").then((value) {
      readEmail = Status.success;
      setState(() {

      });
      if (value != null) {
        print("Emailll: " + value);
        defaultEmail = value;
        loginEmail = defaultEmail;
        print("Emailll: " + loginEmail);
      } else {
        defaultEmail = "";
      }
      if (loginEmail != "") {
        if (isEmail(loginEmail)) {
          isValid[0] = true;
        } else {
          isValid[0] = false;
        }
      }
    });
    print("ASDASDASD " + loginEmail.toString());

    storage.readSecureData("password").then((value) {
      readPw = Status.success;
      setState(() {

      });
      if (value != null) {
        print("passwordpassword: " + value);
        defaultPassword = value;
        loginPassword = defaultPassword;
      } else {
        defaultPassword = "";
      }
      if (loginPassword != "") {
        if (!passwordValidation(loginPassword) || loginPassword.length < 8) {
          isValid[1] = false;
        } else {
          isValid[1] = true;
        }
      }
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ProductListPage()),
            (Route<dynamic> route) => false);
        return Future.value(false);
      },

      child: Scaffold(
        appBar: new AppBar(
          title: Text("Login"),
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ProductListPage()),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: readPw == Status.loading || readEmail == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.1,
                    0.4,
                    0.6,
                    0.9,
                  ],
                  colors: [
                    Colors.white24,
                    Colors.lightBlueAccent,
                    Colors.blueAccent,
                    Colors.indigo,
                  ],
                )),
                child: Container(
                  margin: new EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Text("")),
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(-1.5, -1.5),
                                  color: Colors.grey),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(1.5, -1.5),
                                  color: Colors.grey),
                              Shadow(
                                  // topRight
                                  offset: Offset(1.5, 1.5),
                                  color: Colors.grey),
                              Shadow(
                                  // topLeft
                                  offset: Offset(-1.5, 1.5),
                                  color: Colors.grey),
                            ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        initialValue: defaultEmail,
                        style: TextStyle(fontSize: 20),
                        scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          // icon: Icon(Icons.person),
                          hintText: '',
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
                            loginEmail = value;
                            print(loginEmail);
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (isEmail(value!)) {
                            isValid[0] = true;
                            return null;
                          } else {
                            isValid[0] = false;
                            return "Invalid Email Address";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: defaultPassword,
                        obscureText: true,
                        style: TextStyle(fontSize: 20),
                        scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),

                          // icon: Icon(Icons.person),
                          hintText: '',
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
                            loginPassword = value;
                            print(loginPassword);
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value != null) {
                            if (!passwordValidation(value) &&
                                value.length < 8) {
                              isValid[1] = false;
                              return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                            } else {
                              isValid[1] = false;
                              if (value.length < 8 ||
                                  !passwordValidation(value)) {
                                if (value.length < 8) {
                                  return "Equal to or more than 8 letters and digits";
                                }
                                if (!passwordValidation(value)) {
                                  return "Must have uppercase and lowercase and digit";
                                }
                              } else {
                                isValid[1] = true;
                                return null;
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
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
                                if (isValid[0] && isValid[1]) {
                                  setState(() {});
                                  account = [];
                                  loadingScreen(context);
                                  loginAPI(loginEmail, loginPassword)
                                      .then((value) {
                                    if (status == Status.success) {
                                      Account acc = value;
                                      account.add(acc);
                                      status = Status.loading;
                                      bool isEmailValid = false;
                                      bool isPwValid = false;
                                      for (int i = 0; i < account.length; i++) {
                                        if (account[i].accountEmail ==
                                            loginEmail) {
                                          isEmailValid = true;
                                          if (account[i].accountPassword ==
                                              loginPassword) {
                                            isPwValid = true;
                                          }
                                        }
                                      }
                                      if (isEmailValid && isPwValid) {
                                        login = 1;
                                        print("storage.writeSecureData" +
                                            loginEmail.trim());
                                        storage.writeSecureData(
                                            "email", loginEmail.trim());
                                        setState(() {});
                                        Future.delayed(
                                            Duration(milliseconds: 500), () {
                                          Fluttertoast.showToast(
                                              msg: "Welcome, " +
                                                  value.accountFirstName
                                                      .toString() +
                                                  " " +
                                                  value.accountLastName
                                                      .toString() +
                                                  ".");
                                          navigateToMyProfilePage(context);
                                          if(defaultPassword != loginPassword){
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                content: Text(
                                                  "Do you want to save the password?",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, 'No'),
                                                    child: Text('No'),
                                                  ),
                                                  TextButton(
                                                      child: Text('Yes'),
                                                      onPressed: () {
                                                        storage.writeSecureData(
                                                            "password", loginPassword.trim());
                                                        print(loginPassword.trim());
                                                        Navigator.pop(context);
                                                        Fluttertoast.showToast(
                                                            msg: "Password Saved");
                                                      }),
                                                ],
                                              ),
                                            );
                                          }
                                        });
                                      } else {
                                        if (!isEmailValid) {
                                          Fluttertoast.showToast(
                                              msg: "Wrong Email or Password.");
                                          Navigator.pop(context);
                                        }
                                      }
                                    }
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Wrong Email or Password.");
                                }
                              },
                              child: Text(
                                'LOGIN',
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
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(""),
                            flex: 4,
                          ),
                          Expanded(
                            flex: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () {
                                setState(() {});
                                navigateToRegisterPage(context);
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(""),
                            flex: 3,
                          ),
                          Expanded(
                              flex: 100,
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.focused))
                                      return Colors.red;
                                    return null; // Defer to the widget's default.
                                  }),
                                ),
                                onPressed: () {
                                  navigateToForgetPasswordPage(context);
                                },
                                child: Text(
                                  'FORGET PASSWORD',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Text(""),
                            flex: 4,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
      ),
      // body:
      // ElevatedButton(onPressed: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      // }, child: Text("haha"),),
    );
  }
}
