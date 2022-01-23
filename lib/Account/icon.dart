import 'package:flutter/material.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class IconPage extends StatefulWidget {
  @override
  IconPagePageState createState() => IconPagePageState();
}

class IconPagePageState extends State<IconPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Icon"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      drawer: NavigationBarPageState().navBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
          Image(
            image: NetworkImage(userIcon),
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
