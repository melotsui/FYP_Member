import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Var/natigate.dart';

import '../main.dart';
import '../Var/var.dart';

class NavigationBarPage extends StatefulWidget {
  @override
  NavigationBarPageState createState() => NavigationBarPageState();
}

class NavigationBarPageState extends State<NavigationBarPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget navBar(BuildContext context) {
    return new Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: login > 0
                        ? account[0].image != null
                            ? NetworkImage(
                                apiDomain + account[0].image.toString())
                            : NetworkImage(unknownIcon)
                        : NetworkImage(unknownIcon),
                  ),
                  onTap: () {
                    if (login > 0) {
                      navigateToIconPage(context);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please login",
                      );
                      navigateToLoginPage(context);
                    }
                  },
                ),
                Divider(),
                login > 0
                    ? Text(
                        account[0].accountFirstName! +
                            " " +
                            account[0].accountLastName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : Text(unknownName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                Expanded(child: Text("")),
                // SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    login > 0
                        ? Text(
                            'Balance: \$' +
                                account[0].accountBalance!.toStringAsFixed(2),
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text(""),
                    // login > 0 ? Text(
                    //   displayBalance%2 ==1 ? 'Balance: \$$accountBalance ' : 'Balance: ****** ',
                    //   style: TextStyle(color: Colors.black54),
                    // ) : Text(""),
                    // GestureDetector(
                    //   child: login > 0 ? Icon(
                    //     Icons.add,
                    //     size: 25,
                    //     color: displayBalance%1 ==0 ?
                    //     Colors.black38 : Colors.black,
                    //   ) : Text(""),
                    //   onTap: () {
                    //     // setState(() {
                    //     //
                    //     // });
                    //     // displayBalance = displayBalance + 1;
                    //     navigateToTopUpPage(context);
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              // image: DecorationImage(
              //     image: NetworkImage("https://www.interviewmagazine.com/wp-content/uploads/2015/07/img-justin-bieber_112022637363.jpg"),
              //     fit: BoxFit.contain)
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Products'),
            onTap: () {
              navigateToProductListPage(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.web),
            title: Text('Invoices'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer

              if (login > 0) {
                navigateToInvoiceListPage(context);
              } else {
                Fluttertoast.showToast(
                  msg: "Please login",
                );
                navigateToLoginPage(context);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Branch'),
            onTap: () {
              navigateToBranchListPage(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.wysiwyg),
            title: Text('Notice'),
            onTap: () {
              navigateToNoticeBoardPage(context);
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
              if (login > 0) {
                navigateToMyProfilePage(context);
              } else {
                Fluttertoast.showToast(
                  msg: "Please login",
                );
                navigateToLoginPage(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Navigation Bar"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_alert_sharp),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: navBar(context),
    );
  }
}
