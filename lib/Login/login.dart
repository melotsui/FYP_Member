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

String loginPassword = "";
String loginEmail = "";

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
                onChanged: (String? value) {
                  if (value != null) {
                    loginEmail = value;
                    print(loginEmail);
                  }
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
                onChanged: (String? value) {
                  if (value != null) {
                    loginPassword = value;
                    print(loginPassword);
                  }
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
                        for(int i=0; i<account.length; i++){
                          if(account[i].accountEmail==loginEmail){
                            userIcon = account[i].accountIcon;
                            userFirstName = account[i].accountFirstName;
                            userLastName = account[i].accountLastName;
                            role = account[i].accountRole;
                            userPhone = account[i].accountPhone;
                            userEmail = account[i].accountEmail;
                            userBirthday = account[i].accountBirthday;
                            userGender = account[i].accountGender;
                            accountBalance = account[i].accountBalance;
                            order = account[i].order;
                            point = account[i].point;
                          }
                        }
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
                  Expanded(
                    child: Text(""),
                    flex: 5,
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
                    flex: 5,
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
                    flex: 5,
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
