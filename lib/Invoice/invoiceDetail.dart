import 'package:flutter/material.dart';

import '../Product/productList.dart';
import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class InvoiceDetailPage extends StatefulWidget {
  InvoiceList invoiceDetail;
  InvoiceDetailPage({Key? key, required this.invoiceDetail}) : super(key: key);
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
      body: Column(
        children: <Widget>[
          Card(
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
                            "Invoice ID: " + widget.invoiceDetail.invoiceID,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Date: " + widget.invoiceDetail.date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Time: " + widget.invoiceDetail.time,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Payment: " + widget.invoiceDetail.paymentMethod,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
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
                                    widget.invoiceDetail.invoiceImage)
                                : NetworkImage(unknownIcon),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "\$" + widget.invoiceDetail.totalPrice.toString(),
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
          Expanded(
            child: ListView.builder(
              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: widget.invoiceDetail.productList.length,
              itemBuilder: (BuildContext ctx, index) {
                Product invoiceProduct = product[0];
                for (int i = 0; i < product.length; i++) {
                  if (widget.invoiceDetail.productList[index] ==
                      product[i].productID) {
                    invoiceProduct = product[i];
                  }
                }
                return Container(
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
                                "Product Name: " + invoiceProduct.productName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Quantyty: " + invoiceList[index].date,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Time: " + invoiceList[index].time,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Payment: " + invoiceList[index].paymentMethod,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
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
                                        invoiceList[index].invoiceImage)
                                    : NetworkImage(unknownIcon),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "\$" + invoiceList[index].totalPrice.toString(),
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
                );
              },
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  top: 10,
                  bottom: 10,
                  right: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Text(
                            "Cost before discount",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "\$104.7",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Text(
                            "Discount",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "\$6",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Text(
                            "Total",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "\$98.7",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {},
                          child: Text(
                            'REQUEST REFUND',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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
