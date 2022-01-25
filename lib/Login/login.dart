import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member/Login/register.dart';

import '../Product/productList.dart';
import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';
import '../Account/profile.dart';

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
      body: Container(
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
            )

        ),
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
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                style: TextStyle(fontSize: 20),
                scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),

                  // icon: Icon(Icons.person),
                  hintText: '',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
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
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
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
                        login = 1;
                        setState(() {});
                        navigateToMyProfilePage(context);
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.focused))
                          return Colors.red;
                        return null; // Defer to the widget's default.
                      }),
                    ),
                    onPressed: () {},
                    child: Text(
                      'FORGET PASSWORD',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 10,
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
      // body:
      // ElevatedButton(onPressed: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      // }, child: Text("haha"),),
    );
  }

}
