
import 'package:flutter/material.dart';
import 'Var/var.dart';
import 'Login/login.dart';
import 'Account/account.dart';
import 'Shopping/productList.dart';
import 'Navigation/navigationBar.dart';
import 'Login/register.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    home: new HomePage(),
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/productList': (context) => ProductListPage(),
      '/login': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      // '/second': (context) => const SecondScreen(),
    },
  ));
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
    Container(color: Colors.grey,),
    login < 1 ? LoginPage() : Container(color: Colors.green,),
    login < 1 ? LoginPage() : AccountPage(),
  ];

  Widget build(BuildContext context) {
    return NavigationBarPage();
  }
}