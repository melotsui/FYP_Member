import 'package:flutter/material.dart';
import 'Var/var.dart';
import 'Login/login.dart';
import 'Account/profile.dart';
import 'Product/productList.dart';
import 'Navigation/navigationBar.dart';
import 'Login/register.dart';
import 'Invoice/invoiceList.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(
    MaterialApp(
      home: new HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> pages = [
    ProductListPage(),
    Container(
      color: Colors.grey,
    ),
    login < 1
        ? LoginPage()
        : Container(
            color: Colors.green,
          ),
    login < 1 ? LoginPage() : MyProfilePage(),
  ];

  Widget build(BuildContext context) {
    return ProductListPage();
  }
}
