import 'package:flutter/material.dart';

import '../Product/productList.dart';
import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class InvoiceDetailPage extends StatefulWidget {
  @override
  InvoiceDetailPageState createState() => InvoiceDetailPageState();
}

class InvoiceDetailPageState extends State<InvoiceDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Invoice Detail"),
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
          Expanded(
            child: ListView.builder(
              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: 5,
                itemBuilder: (BuildContext ctx, index) {
                  return Card(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07, top: 20, bottom: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
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
                                    "Payment Method: Account Balance",
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
                            decoration: BoxDecoration(

                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: login > 0 ? NetworkImage(product[index].productImage) : NetworkImage(unknownIcon),

                                    ),
                                    onTap: () {
                                      login > 0 ? navigateToMyProfilePage(context) : navigateToLoginPage(context);
                                    },
                                  ),
                                ),
                                SizedBox(height: 5,),
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
