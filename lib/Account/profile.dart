import 'package:flutter/material.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class AccountPage extends StatefulWidget {
  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
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
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("$appBarTitle"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.app_registration),
          ),
        ],
      ),
      drawer: NavigationBarPageState().navBar(context),
      body: Container(
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
                      onTap: () {},
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 35, left: 50),
                        child: Text(
                          userName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 50),
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
                    "$userTel",
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
            Divider(color: Colors.black),
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
                        "12",
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
                        "842",
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
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Products'),
                    onTap: () {
                      appBarTitle = "Product List";

                      Navigator.pushNamed(context, '/productList');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Products'),
                    onTap: () {
                      appBarTitle = "Product List";

                      Navigator.pushNamed(context, '/productList');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.web),
                    title: Text('Invoices'),
                    onTap: () {
                      appBarTitle = "Invoices";
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pushNamed(context, '/invoiceList');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.store),
                    title: Text('Branch'),
                    onTap: () {
                      appBarTitle = "Branch";
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                    ),
                    title: Text('Profile'),
                    onTap: () {
                      appBarTitle = "My Profile";
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pushNamed(context, '/myProfile');
                    },
                  ),
                  Divider(color: Colors.black),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                    ),
                    title: Text('Profile'),
                    onTap: () {
                      appBarTitle = "My Profile";
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pushNamed(context, '/myProfile');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // body:
      // ElevatedButton(onPressed: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      // }, child: Text("haha"),),
    );
  }
}
