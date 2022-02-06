import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Var/natigate.dart';
import 'package:member/Var/var.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  List<bool> isValid = [false, false, false];
  String oldPW = "";
  String newPW = "";
  String confirmPW = "";
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
      body: Container(
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
                  helperText: 'Assistive text',
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
                      if (value.length < 8 || !passwordValidation(value)) {
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
                  helperText: 'Assistive text',
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
                      if (value.length < 8 || !passwordValidation(value)) {
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
                  helperText: 'Assistive text',
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
                onSaved: (String? value) {
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value != null) {
                    if (!passwordValidation(value) && value.length < 8) {
                      isValid[2] = false;
                      return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                    } else {
                      if (value.length < 8 || !passwordValidation(value)) {
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
                      if(isValid[0] && isValid[1] && isValid[2]){
                        // if (oldPW != "" && newPW != "" && confirmPW != "") {
                          if (newPW == confirmPW) {
                            if (oldPW == userPw) {
                              userPw = confirmPW;
                              for (int i = 0; i < account.length; i++) {
                                if (userEmail == account[i].accountEmail) {
                                  account[i].accountPassword = userPw;
                                }
                              }
                              print(userPw);
                              Fluttertoast.showToast(
                                  msg: "Password Changed.");
                              navigateToMyProfilePage(context);
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
                        String errMsg = "The following field(s) is invalid:";
                        if(!isValid[0]){
                          errMsg += "\n- Old Password";
                        }
                        if(!isValid[1]){
                          errMsg += "\n- New Password";
                        }
                        if(!isValid[2]){
                          errMsg += "\n- Confirm Password";
                        }
                        Fluttertoast.showToast(
                            msg: errMsg);
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
