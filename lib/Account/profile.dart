import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Login/login.dart';
import 'package:member/Var/natigate.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
    print(account[0].accountID.toString());
    updateAccountAPI(account[0].accountID.toString()).then((value){
      account = [];
      account.add(value);
      print(value.image.toString());
      setState(() {

      });
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(
              "Are you sure you want to log out?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('Cancel'),
              ),
              TextButton(
                  child: Text('Log Out'),
                  onPressed: () {
                    login = 0;
                    Fluttertoast.showToast(msg: "Log Out Successful");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  }),
            ],
          ),
        );
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
        body: status == Status.loading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurpleAccent,
          ),
        )
            : SingleChildScrollView(
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
                                  backgroundImage:
                                  login > 0 ? account[0].image.toString() != null ? NetworkImage(apiDomain + account[0].image.toString()) : NetworkImage(unknownIcon) :
                                  NetworkImage(unknownIcon),
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
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Text(
                                    account[0].accountFirstName! + " " + account[0].accountLastName!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5,
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Text(
                                    role!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
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
                              account[0].accountPhone!,
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
                              account[0].accountEmail!,
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
                                  "\$" + account[0].accountBalance!.toStringAsFixed(2),
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
                                  account[0].order.toString(),
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
                                  account[0].point.toString(),
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
                              leading: Icon(Icons.attach_money),
                              title: Text('Top Up'),
                              onTap: () {
                                navigateToTopUpPage(context);
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
                              leading: Icon(Icons.lock_open),
                              title: Text('Change Password'),
                              onTap: () {
                                navigateToChangePasswordPage(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.face),
                              title: Text('Title'),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(Icons.face),
                              title: Text('Title'),
                              onTap: () {},
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
                                  color: Colors.deepPurpleAccent,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: Text(
                                      "Are you sure you want to log out?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                            account = [
                                              Account(
                                                accountID: '',
                                                accountFirstName: '',
                                                accountLastName: '',
                                                // accountIcon:
                                                //     'https://image-resizer.cwg.tw/resize/uri/https%3A%2F%2Fcw1.tw%2FCC%2Fimages%2Farticle%2F201710%2Farticle-59d1f2b06a7a2.jpg/?w=810&h=543&fit=fill',
                                                accountRole: '',
                                                accountPhone: '',
                                                accountEmail: '',
                                                accountBirthday: "",
                                                accountPassword: "",
                                                accountGender: "",
                                                accountBalance: 0,
                                                order: 0,
                                                point: 0,
                                              ),];
                                            login = 0;
                                            Fluttertoast.showToast(
                                                msg: "Log Out Successful");
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage()),
                                                    (Route<dynamic> route) =>
                                                        false);
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
