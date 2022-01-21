import 'package:flutter/material.dart';

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


  Widget navBar(BuildContext context){
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
                    backgroundImage: login > 0 ? NetworkImage(userIcon) : NetworkImage(unknownIcon),
                  ),
                  onTap: () {
                    login > 0 ? null : Navigator.pushNamed(context, '/login');
                  },
                ),
                Divider(),
                login > 0 ?
                Text(userName,style: TextStyle(fontWeight: FontWeight.bold),) :
                Text(unknownName,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    login > 0 ? Text(
                      displayBalance%2 ==1 ? 'Balance: \$$accountBalance ' : 'Balance: ****** ',
                      style: TextStyle(color: Colors.black54),
                    ) : Text(""),
                    GestureDetector(
                      child: login > 0 ? Icon(
                        Icons.remove_red_eye,
                        color: displayBalance%1 ==0 ?
                        Colors.black38 : Colors.black,
                      ) : Text(""),
                      onTap: () {
                        // setState(() {
                        //
                        // });
                        displayBalance = displayBalance + 1;


                      },
                    ),

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
            leading: Icon(Icons.account_circle,),
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
    );
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("$appBarTitle"),
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