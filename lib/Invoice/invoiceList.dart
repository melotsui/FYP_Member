import 'package:flutter/material.dart';

import '../Var/natigate.dart';
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
          // Container(
          //   padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
          //   child: TextField(
          //     // obscureText: true,
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(),
          //       // hintText: 'Input invoice ID',
          //       labelText: 'Search Invoice',
          //     ),
          //     onChanged: (text) {
          //       // searchProduct = [];
          //       // print(searchProduct);
          //       // print(product);
          //       // if (text != "") {
          //       //   for (int i = 0; i < product.length; i++) {
          //       //     if (product[i]
          //       //         .productName
          //       //         .toLowerCase()
          //       //         .contains(text.toLowerCase())) {
          //       //       searchProduct.add(product[i]);
          //       //     }
          //       //   }
          //       // } else {
          //       //   searchProduct = product;
          //       // }
          //       // setState(() {});
          //     },
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: 5,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.07,
                            top: 20,
                            bottom: 10,
                            right: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Invoice ID: 989607210831",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Date: 2021.03.31",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Time: 23:59:59",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Payment: Account Balance",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: login > 0
                                          ? NetworkImage(
                                              product[index].productImage)
                                          : NetworkImage(unknownIcon),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "\$1000",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      navigateToInvoiceDetailPage(context);
                    },
                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}
