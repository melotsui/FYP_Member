import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../Product/productList.dart';
import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';
import 'invoiceList.dart';

Status invoiceStatus = Status.loading;
Future<Invoice> invoiceAPI(String id) async {
  invoiceStatus = Status.loading;
  final response =
      await http.post(Uri.parse('http://api.chunon.me/getMemberInvoice'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"invoiceID": id}));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    invoiceStatus = Status.success;
    // List b = jsonDecode(response.body);
    // print(b);
    return Invoice.fromJson(jsonDecode(response.body));
  } else {
    invoiceStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Invoice {
  String? invoiceID;
  String? accountID;
  String? payMethod;
  String? posID;
  String? invoiceDateTime;
  String? branchID;
  double? finalPrice;
  double? oldPrice;
  String? refundID;
  String? staffID;
  String? createDateTime;
  String? refundDateTime;
  int? isApprove;
  String? branchName;
  List<InvoiceDetail>? invoiceDetail;

  Invoice(
      {this.invoiceID,
      this.accountID,
      this.payMethod,
      this.posID,
      this.invoiceDateTime,
      this.branchID,
      this.finalPrice,
      this.oldPrice,
      this.refundID,
      this.staffID,
      this.createDateTime,
      this.refundDateTime,
      this.isApprove,
      this.branchName,
      this.invoiceDetail});

  Invoice.fromJson(Map<String, dynamic> json) {
    invoiceID = json['invoiceID'];
    accountID = json['accountID'];
    payMethod = json['payMethod'];
    posID = json['posID'];
    invoiceDateTime = json['invoiceDateTime'];
    branchID = json['branchID'];
    finalPrice = json['finalPrice'];
    oldPrice = json['oldPrice'];
    refundID = json['refundID'];
    staffID = json['staffID'];
    createDateTime = json['createDateTime'];
    refundDateTime = json['refundDateTime'];
    isApprove = json['isApprove'];
    branchName = json['branchName'];
    if (json['invoiceDetail'] != null) {
      invoiceDetail = <InvoiceDetail>[];
      json['invoiceDetail'].forEach((v) {
        invoiceDetail!.add(new InvoiceDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoiceID'] = this.invoiceID;
    data['accountID'] = this.accountID;
    data['payMethod'] = this.payMethod;
    data['posID'] = this.posID;
    data['invoiceDateTime'] = this.invoiceDateTime;
    data['branchID'] = this.branchID;
    data['finalPrice'] = this.finalPrice;
    data['oldPrice'] = this.oldPrice;
    data['refundID'] = this.refundID;
    data['staffID'] = this.staffID;
    data['createDateTime'] = this.createDateTime;
    data['refundDateTime'] = this.refundDateTime;
    data['isApprove'] = this.isApprove;
    data['branchName'] = this.branchName;
    if (this.invoiceDetail != null) {
      data['invoiceDetail'] =
          this.invoiceDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceDetail {
  String? productID;
  String? productImage;
  String? productName;
  int? qty;
  double? price;
  double? retailPrice;

  InvoiceDetail({
    this.productID,
    this.productImage,
    this.productName,
    this.qty,
    this.price,
    this.retailPrice,
  });

  InvoiceDetail.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productImage = json['productImage'];
    productName = json['productName'];
    qty = json['qty'];
    price = json['price'];
    retailPrice = json['retailPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['productImage'] = this.productImage;
    data['productName'] = this.productName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['retailPrice'] = this.retailPrice;
    return data;
  }
}

Status refundStatus = Status.loading;
Future<Refund> requestRefundAPI(String id) async {
  refundStatus = Status.loading;
  final response =
      await http.post(Uri.parse('http://api.chunon.me/requestRefund'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"invoiceID": id}));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    refundStatus = Status.success;
    // List b = jsonDecode(response.body);
    // print(b);
    return Refund.fromJson(jsonDecode(response.body));
  } else {
    refundStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Refund> deleteRefundAPI(String id) async {
  refundStatus = Status.loading;
  final response =
      await http.post(Uri.parse('http://api.chunon.me/deleteRefund'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"refundID": id}));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    refundStatus = Status.success;
    // List b = jsonDecode(response.body);
    // print(b);
    print("asd");
    return Refund.fromJson(jsonDecode(response.body));
  } else {
    refundStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Refund {
  int? success;

  Refund({this.success});

  Refund.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}

class InvoiceDetailPage extends StatefulWidget {
  String invoiceID;
  InvoiceDetailPage({Key? key, required this.invoiceID}) : super(key: key);
  @override
  InvoiceDetailPageState createState() => InvoiceDetailPageState();
}

class InvoiceDetailPageState extends State<InvoiceDetailPage> {
  late Invoice invoice;
  late List<InvoiceDetail> detail;
  late String date;
  late String time;
  late int refundStatus;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    invoiceAPI(widget.invoiceID).then((value) {
      invoice = value;
      detail = invoice.invoiceDetail!;
      var dt = DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(invoice.invoiceDateTime.toString());
      date = dateFormatter(dt);
      time = timeFormatter(dt);
      print(invoice.isApprove);
      if (invoice.refundID == null) {
        refundStatus = 1; // Invoice is not required to refund
      } else {
        if (invoice.isApprove == null) {
          refundStatus = 2; // Waiting approval
        } else {
          refundStatus = 3; // Approved
        }
      }
      print(detail[0].productName.toString() + date + time);
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigateToInvoiceListPage(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Invoice Detail"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              navigateToInvoiceListPage(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: invoiceStatus == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              )
            : Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      invoice.branchName.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.purple),
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
                                    "Invoice ID: " + widget.invoiceID,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Date: " + date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Time: " + time,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Payment: " + invoice.payMethod.toString(),
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
                                    backgroundImage:
                                        AssetImage('assets/BranchImage.jpg'),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Container(
                                //   width: 80,
                                //   child: Text(
                                //     invoice.branchName.toString(),
                                //     style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       fontSize: 15,
                                //       color: Colors.green,
                                //     ),
                                //   ),
                                // ),
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
                      itemCount: detail.length,
                      itemBuilder: (BuildContext ctx, index) {
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Product Name: " +
                                            detail[index]
                                                .productName
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Price: " +
                                                  "\$" +
                                                  detail[index]
                                                      .retailPrice
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Discount: " +
                                            "\$" +
                                            (detail[index].retailPrice! -
                                                    detail[index].price!)
                                                .toStringAsFixed(1),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Total: " +
                                            "\$" +
                                            detail[index].price.toString(),
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
                                          backgroundImage: NetworkImage(
                                              apiDomain +
                                                  detail[index]
                                                      .productImage
                                                      .toString())),
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
                                    "Price before discount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "\$" + invoice.oldPrice.toString(),
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    "Discount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "\$" +
                                        (invoice.finalPrice! -
                                                invoice.oldPrice!)
                                            .toStringAsFixed(1),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "\$" + invoice.finalPrice.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                                    primary: refundStatus == 2
                                        ? Colors.red
                                        : refundStatus == 1
                                            ? Colors.deepPurpleAccent
                                            : Colors.blueAccent, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () {
                                    if (refundStatus != 3) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          content: Text(
                                            refundStatus == 2
                                                ? "Are you sure you want to cancel refund request?"
                                                : "Are you sure you want to push refund request?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                                child: Text('Yes'),
                                                onPressed: () {
                                                  if (refundStatus == 1) {
                                                    requestRefundAPI(
                                                            widget.invoiceID)
                                                        .then((value) {
                                                      if (value.success !=
                                                              null &&
                                                          refundStatus !=
                                                              Status.loading) {
                                                        navigateToInvoiceDetailPage(
                                                            context,
                                                            widget.invoiceID);
                                                      }
                                                    });
                                                  } else if (refundStatus ==
                                                      2) {
                                                    print(invoice.refundID
                                                        .toString());
                                                    deleteRefundAPI(invoice
                                                            .refundID
                                                            .toString())
                                                        .then((value) {
                                                      if (value.success !=
                                                              null &&
                                                          refundStatus !=
                                                              Status.loading) {
                                                        navigateToInvoiceDetailPage(
                                                            context,
                                                            widget.invoiceID);
                                                      }
                                                    });
                                                  }
                                                }),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    refundStatus == 2
                                        ? "Waiting Approval"
                                        : refundStatus == 1
                                            ? "Request Refund"
                                            : "Approved",
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
      ),
    );
  }
}
