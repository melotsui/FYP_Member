import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Var/var.dart';
import 'package:string_validator/string_validator.dart';

import '../Login/login.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Container(
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
                        Fluttertoast.showToast(
                          msg:
                              "One time password will send to you email address.",
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (Route<dynamic> route) => false);
                      } else {
                        Fluttertoast.showToast(msg: "Invalid Email.");
                      }
                      // login = 1;
                      // setState(() {});
                      // navigateToMyProfilePage(context);
                    },
                    child: Text(
                      'SEND ONE TIME PASSWORD',
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
