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
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Quantity: " + "1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Price: " +
                                          invoiceProduct.retailPrice.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Discount: " +
                                    (invoiceProduct.retailPrice -
                                            invoiceProduct.sellPrice)
                                        .toStringAsFixed(1),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Total: " + invoiceProduct.sellPrice.toString(),
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
                                    ? NetworkImage(invoiceProduct.productImage)
                                    : NetworkImage(unknownIcon),
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
                            "\$238.0",
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
                            "-\$70.6",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.red),
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
                            "\$" + widget.invoiceDetail.totalPrice.toString(),
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
                            primary: widget.invoiceDetail.request ? Colors.blueAccent : Colors.deepPurpleAccent, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: Text(
                                  widget.invoiceDetail.request ? "Are you sure you want to cancel refund request?" : "Are you sure you want to push refund request?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        if(!widget.invoiceDetail.request){
                                          widget.invoiceDetail.request = true;
                                        }
                                        else{
                                          widget.invoiceDetail.request = false;
                                        }
                                        for(int i=0; i<invoiceList.length; i++){
                                          if(invoiceList[i].invoiceID == widget.invoiceDetail.invoiceID){
                                            invoiceList[i] = widget.invoiceDetail;
                                          }
                                        }
                                        Navigator.pop(context, 'Yes');
                                        setState(() {

                                        });
                                      }),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            widget.invoiceDetail.request ? 'Waiting Approval' : 'REQUEST REFUND',
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
