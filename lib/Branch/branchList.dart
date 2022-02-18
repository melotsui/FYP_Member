import 'package:flutter/material.dart';

import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class BranchListPage extends StatefulWidget {
  @override
  BranchListPageState createState() => BranchListPageState();
}

class BranchListPageState extends State<BranchListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Branch"),
        centerTitle: true,
      ),
      drawer: NavigationBarPageState().navBar(context),
      body: Column(
        children: <Widget>[
        ],
      ),
    );
  }
}
