import 'package:flutter/material.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';

class invoiceListPage extends StatefulWidget {
  @override
  invoiceListPageState createState() => invoiceListPageState();
}

class invoiceListPageState extends State<invoiceListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: Text("Invoice"),
        centerTitle: true,
      ),

      // body:
      // ElevatedButton(onPressed: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      // }, child: Text("haha"),),
    );
  }
}