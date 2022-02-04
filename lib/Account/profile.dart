import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Login/login.dart';
import 'package:member/Var/natigate.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class MyProfilePage extends StatefulWidget {
  @override
  MyProfilePageState createState() => MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var profileItem = [
    'Change Password',
    'Subtitle',
    'Subtitle',
    'Subtitle',
    'Subtitle'
  ];
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        login = 0;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("My Profile"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                navigateToEditProfilePage(context);
              },
              icon: Icon(Icons.app_registration),
            ),
          ],
        ),
        drawer: NavigationBarPageState().navBar(context),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: login > 0
                                ? NetworkImage(userIcon)
                                : NetworkImage(unknownIcon),
                          ),
                          onTap: () {
                            navigateToIconPage(context);
                          },
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: 35,
                                left: MediaQuery.of(context).size.width * 0.1),
                            child: Text(
                              userFirstName + " " + userLastName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5,
                                left: MediaQuery.of(context).size.width * 0.1),
                            child: Text(
                              role,
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black54),
                            ),
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Icon(Icons.call),
                    ),
                    Container(
                      child: Text(
                        "$userPhone",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Icon(Icons.email_outlined),
                    ),
                    Container(
                      child: Text(
                        "$userEmail",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(color: Colors.black54),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          Text(
                            "\$$accountBalance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Wallet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Column(
                        children: [
                          Text(
                            "$order",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Orders",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      // child: Text(price[idx], textAlign: TextAlign.center),
                      child: Column(
                        children: [
                          Text(
                            "$point",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Point",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.black),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.lock_open),
                        title: Text('Change Password'),
                        onTap: () {
                          navigateToChangePasswordPage(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.qr_code_scanner),
                        title: Text('Connect to POS'),
                        onTap: () {
                          navigateToScanQRCodePage(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.web),
                        title: Text('Invoices'),
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('AlertDialog Title'),
                              content: Text('AlertDialog description'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.store),
                        title: Text('Branch'),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.account_circle,
                        ),
                        title: Text('Profile'),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                        },
                      ),
                      Divider(color: Colors.black),
                      ListTile(
                        leading: Icon(
                          Icons.power_settings_new,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Log out',
                          style: TextStyle(
                            color: Color.fromRGBO(249, 162, 193, 100),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: Text(
                                "Are you sure you want to log out?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                    child: Text('Log Out'),
                                    onPressed: () {
                                      login = 0;
                                      Fluttertoast.showToast(msg: "Log Out Successful");
                                      navigateToLoginPage(context);
                                    }),
                              ],
                            ),
                          );
                          // appBarTitle = "productList";
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // body:
        // ElevatedButton(onPressed: (){
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
        // }, child: Text("haha"),),
      ),
    );
  }
}
