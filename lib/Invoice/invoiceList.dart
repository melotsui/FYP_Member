import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

Status invoicesStatus = Status.loading;
Future<List<Invoices>> invoicesAPI(String id) async {
  productsStatus = Status.loading;
  final response = await http.post(
      Uri.parse('http://api.chunon.me/getMemberInvoices'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"accountID": id})
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    invoicesStatus = Status.success;
    // List b = jsonDecode(response.body);
    // print(b);
    List<Invoices> myModels = (jsonDecode(response.body) as List)
        .map((i) => Invoices.fromJson(i))
        .toList();
    print(myModels);
    return myModels;
  } else {
    invoicesStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class InvoiceListPage extends StatefulWidget {
  @override
  InvoiceListPageState createState() => InvoiceListPageState();
}

class InvoiceListPageState extends State<InvoiceListPage> {
  @override
  late List<Invoices> invoices;
  late List<String> dateList;
  late List<String> timeList;
  void initState() {
    // TODO: implement initState
    super.initState();
    updateAccountAPI(account[0].accountID.toString()).then((value) {
      account = [];
      account.add(value);
      setState(() {});
    });
    print("ID; " + account[0].accountID.toString());
    invoicesAPI(account[0].accountID.toString()).then((value) {
      invoices = [];
      invoices = value;
      dateList = [];
      timeList = [];
      for(int i=0; i<invoices.length; i++){
        var dt = DateFormat("yyyy-MM-dd HH:mm:ss").parse(invoices[i].invoiceDateTime.toString());
        print(dateFormatter(dt));
        print(timeFormatter(dt));
        dateList.add(dateFormatter(dt));
        timeList.add(timeFormatter(dt));
      }
      setState(() {});
    });
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
      body: status == Status.loading || invoicesStatus == Status.loading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurpleAccent,
        ),
      )
          : Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: invoices.length,
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
                                      "Invoice ID: " + invoices[index].invoiceID.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Date: " + dateList[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Time: " + timeList[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Payment: " + invoices[index].payMethod.toString(),
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
                                          apiDomain + invoices[index].productImage.toString())
                                          : NetworkImage(unknownIcon),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "\$" + invoices[index].finalPrice.toString(),
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
                      navigateToInvoiceDetailPage(context, invoiceList[index]);
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

String dateFormatter(var dt) {
  String str = toTens(dt.year.toString()) + "-" + toTens(dt.month.toString()) + "-" + toTens(dt.day.toString());
  return str;
}

String timeFormatter(var dt) {
  String str = toTens(dt.hour.toString()) + ":" + toTens(dt.minute.toString()) + ":" + toTens(dt.second.toString());
  return str;
}

String toTens(String str){
  if(str.length == 1) {
    return "0" + str;
  } else {
    return str;
  }
}