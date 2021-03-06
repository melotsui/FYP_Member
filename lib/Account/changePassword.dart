import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Var/natigate.dart';
import 'package:member/Var/var.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

Future<ChangePassword> changePasswordAPI(String id, String oldPw, String newPw) async {
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
    return ChangePassword.fromJson(jsonDecode(response.body));
  } else {
    status = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to change password');
  }
}

class ChangePassword {
  String? success;

  ChangePassword({this.success});

  ChangePassword.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}

class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  List<bool> isValid = [false, false, false];
  String oldPW = "";
  String newPW = "";
  String confirmPW = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateAccountAPI(account[0].accountID.toString()).then((value) {
      account = [];
      account.add(value);
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Change Password"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: status == Status.loading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(fontSize: 20),
                      scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        // helperText: '',
                        // icon: Icon(Icons.person),
                        hintText: '',
                        labelText: 'Old Password',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          if (value != "") {
                            oldPW = value;
                            print(oldPW);
                          }
                        }
                      },
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value != null) {
                          if (!passwordValidation(value) && value.length < 8) {
                            isValid[0] = false;
                            return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                          } else {
                            if (value.length < 8 ||
                                !passwordValidation(value)) {
                              isValid[0] = false;
                              if (value.length < 8) {
                                return "Equal to or more than 8 letters and digits";
                              }
                              if (!passwordValidation(value)) {
                                return "Must have uppercase and lowercase and digit";
                              }
                            } else {
                              isValid[0] = true;
                              return null;
                            }
                          }
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      obscureText: true,
                      scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        // helperText: '',
                        // icon: Icon(Icons.person),
                        hintText: '',
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          if (value != "") {
                            newPW = value;
                            print(newPW);
                          }
                        }
                      },
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value != null) {
                          if (!passwordValidation(value) && value.length < 8) {
                            isValid[1] = false;
                            return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                          } else {
                            if (value.length < 8 ||
                                !passwordValidation(value)) {
                              isValid[1] = false;
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
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      obscureText: true,
                      scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        // helperText: '',
                        // icon: Icon(Icons.person),
                        hintText: '',
                        labelText: 'Confirm New Password',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          if (value != "") {
                            confirmPW = value;
                            print(confirmPW);
                          }
                        }
                      },
                      onSaved: (String? value) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value != null) {
                          if (!passwordValidation(value) && value.length < 8) {
                            isValid[2] = false;
                            return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                          } else {
                            if (value.length < 8 ||
                                !passwordValidation(value)) {
                              isValid[2] = false;
                              if (value.length < 8) {
                                return "Equal to or more than 8 letters and digits";
                              }
                              if (!passwordValidation(value)) {
                                return "Must have uppercase and lowercase and digit";
                              }
                            } else {
                              isValid[2] = true;
                              return null;
                            }
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                            if (isValid[0] && isValid[1] && isValid[2]) {
                              // if (oldPW != "" && newPW != "" && confirmPW != "") {
                              if (newPW == confirmPW) {
                                if (oldPW == account[0].accountPassword.toString()) {
                                  changePasswordAPI(account[0].accountID.toString(), oldPW, newPW).then((value) {
                                    Fluttertoast.showToast(
                                        msg: "Password Changed.");
                                    navigateToMyProfilePage(context);
                                    setState(() {});
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Wrong Old Password.");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Confirm Password must be equal to New Password.");
                              }
                              //   } else {
                              //     Fluttertoast.showToast(
                              //         msg: "Please enter the confirm password.");
                              //   }
                              // } else {
                              //   Fluttertoast.showToast(
                              //       msg: "Please enter the new password.");
                              // }
                              // } else {
                              //   String errMsg = "The following field(s) cannot be null:";
                              //   if(oldPW == ""){
                              //     errMsg += "\n- Old Password";
                              //   }
                              //   if(newPW == ""){
                              //     errMsg += "\n- New Password";
                              //   }
                              //   if(confirmPW == ""){
                              //     errMsg += "\n- Confirm Password";
                              //   }
                              //   Fluttertoast.showToast(
                              //       msg: errMsg);
                              // }
                            } else {
                              String errMsg =
                                  "The following field(s) is invalid:";
                              if (!isValid[0]) {
                                errMsg += "\n- Old Password";
                              }
                              if (!isValid[1]) {
                                errMsg += "\n- New Password";
                              }
                              if (!isValid[2]) {
                                errMsg += "\n- Confirm Password";
                              }
                              Fluttertoast.showToast(msg: errMsg);
                            }
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
