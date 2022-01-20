import 'package:flutter/material.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),

      // body:
      // ElevatedButton(onPressed: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      // }, child: Text("haha"),),
    );
  }
}