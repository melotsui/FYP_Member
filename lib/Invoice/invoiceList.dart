import 'package:flutter/material.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class InvoiceListPage extends StatefulWidget {
  @override
  InvoiceListPageState createState() => InvoiceListPageState();
}

class InvoiceListPageState extends State<InvoiceListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Invoice List"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.add_alert_sharp),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.share),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.search),
        //   ),
        // ],
      ),
      drawer: NavigationBarPageState().navBar(context),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: TextField(
              // obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Search Invoice',
              ),
              onChanged: (text) {
                // searchProduct = [];
                // print(searchProduct);
                // print(product);
                // if (text != "") {
                //   for (int i = 0; i < product.length; i++) {
                //     if (product[i]
                //         .productName
                //         .toLowerCase()
                //         .contains(text.toLowerCase())) {
                //       searchProduct.add(product[i]);
                //     }
                //   }
                // } else {
                //   searchProduct = product;
                // }
                // setState(() {});
              },
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "asd",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
