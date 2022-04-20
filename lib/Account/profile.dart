import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Login/login.dart';
import 'package:member/Var/natigate.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

Status balanceRecordsStatus = Status.loading;
Future<List<BalanceRecords>> balanceRecordsAPI(String id) async {
  balanceRecordsStatus = Status.loading;
  final response = await http.post(
    Uri.parse('http://api.chunon.me/getAccountBalanceRecord'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"accountID": id}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    balanceRecordsStatus = Status.success;
    List<BalanceRecords> myModels = (jsonDecode(response.body) as List)
        .map((i) => BalanceRecords.fromJson(i))
        .toList();
    return myModels;
  } else {
    balanceRecordsStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get NoticeBoard');
  }
}

class BalanceRecords {
  int? isAdd;
  double? balance;
  String? payMethod;
  String? balanceRecordDateTime;

  BalanceRecords(
      {this.isAdd, this.balance, this.payMethod, this.balanceRecordDateTime});

  BalanceRecords.fromJson(Map<String, dynamic> json) {
    isAdd = json['isAdd'];
    balance = json['balance'];
    payMethod = json['payMethod'];
    balanceRecordDateTime = json['balanceRecordDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAdd'] = this.isAdd;
    data['balance'] = this.balance;
    data['payMethod'] = this.payMethod;
    data['balanceRecordDateTime'] = this.balanceRecordDateTime;
    return data;
  }
}

class MyProfilePage extends StatefulWidget {
  @override
  MyProfilePageState createState() => MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
  List<BalanceRecords> balanceRecords = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(account[0].accountID.toString());
    updateAccountAPI(account[0].accountID.toString()).then((value) {
      account = [];
      account.add(value);
      print(value.image.toString());
      print("PASSCODE " + account[0].passcode.toString());
      // if (account[0].passcode.toString() == "") {
      //   screenLock(context: context, canCancel: true, correctString: "");
      // }
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(
              "Are you sure you want to log out?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('Cancel'),
              ),
              TextButton(
                  child: Text('Log Out'),
                  onPressed: () {
                    login = 0;
                    Fluttertoast.showToast(msg: "Log Out Successful");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  }),
            ],
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("My Profile"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                navigateToEditProfilePage(context);
              },
              icon: Icon(Icons.app_registration),
            ),
          ],
        ),
        drawer: NavigationBarPageState().navBar(context),
        body: status == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: account[0].image != null
                                          ? NetworkImage(apiDomain +
                                              account[0].image.toString())
                                          : NetworkImage(unknownIcon)
                                ),
                                onTap: () {
                                  navigateToIconPage(context);
                                },
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 35,
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Text(
                                    account[0].accountFirstName! +
                                        " " +
                                        account[0].accountLastName!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5,
                                      left: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Text(
                                    role!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Icon(Icons.call),
                          ),
                          Container(
                            child: Text(
                              account[0].accountPhone!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Icon(Icons.email_outlined),
                          ),
                          Container(
                            child: Text(
                              account[0].accountEmail!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(color: Colors.black54),
                      Row(
                        children: <Widget>[
                          Expanded(child: Container()),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                balanceRecordsAPI(
                                        account[0].accountID.toString())
                                    .then(
                                  (value) {
                                    balanceRecords = value;
                                    setState(() {});
                                    showModalBottomSheet(
                                      useRootNavigator: true,
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)),
                                      ),
                                      backgroundColor: Colors.white,
                                      builder: (BuildContext context) =>
                                          Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(top: 5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Divider(
                                                thickness: 3,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    balanceRecords.length,
                                                itemBuilder:
                                                    (BuildContext ctx, index) {
                                                  return GestureDetector(
                                                    child: Container(
                                                      child: Card(
                                                        child: Row(
                                                          children: <Widget>[
                                                            // Expanded(
                                                            //   flex: 7,
                                                            //   child: Column(
                                                            //     children: <
                                                            //         Widget>[
                                                            //       Row(children: <Widget>[
                                                            //         Container(
                                                            //           alignment:
                                                            //           Alignment
                                                            //               .centerLeft,
                                                            //           child: Text("Date Time: "),
                                                            //         ),
                                                            //         Container(
                                                            //           alignment:
                                                            //           Alignment
                                                            //               .centerLeft,
                                                            //           child: Text(
                                                            //               balanceRecords[
                                                            //               index]
                                                            //                   .balanceRecordDateTime
                                                            //                   .toString()),
                                                            //         ),
                                                            //       ],),
                                                            //       Column(
                                                            //         children: <Widget>[
                                                            //           Container(
                                                            //             alignment:
                                                            //             Alignment
                                                            //                 .centerLeft,
                                                            //             child: Text("Payment Method: "),
                                                            //           ),
                                                            //           Container(
                                                            //             alignment:
                                                            //             Alignment
                                                            //                 .centerLeft,
                                                            //             child: Text(
                                                            //                 balanceRecords[
                                                            //                 index]
                                                            //                     .payMethod
                                                            //                     .toString()),
                                                            //           ),
                                                            //         ],
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                            // Expanded(
                                                            //   flex: 3,
                                                            //   child: Container(
                                                            //     alignment: Alignment
                                                            //         .centerRight,
                                                            //     child: balanceRecords[
                                                            //     index]
                                                            //         .isAdd ==
                                                            //         1
                                                            //         ? Text("+ \$" +
                                                            //         balanceRecords[
                                                            //         index]
                                                            //             .balance
                                                            //             .toString(), style: TextStyle(color: Colors.green),)
                                                            //         : Text("- \$" +
                                                            //         balanceRecords[
                                                            //         index]
                                                            //             .balance
                                                            //             .toString(), style: TextStyle(color: Colors.red)),
                                                            //   ),
                                                            // ),
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            15),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              5),
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        balanceRecords[index]
                                                                            .balanceRecordDateTime
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              5),
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        balanceRecords[index]
                                                                            .payMethod
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            15),
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: balanceRecords[index]
                                                                            .isAdd ==
                                                                        1
                                                                    ? Text(
                                                                        "+ \$" +
                                                                            balanceRecords[index].balance.toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.green),
                                                                      )
                                                                    : Text(
                                                                        "- \$" +
                                                                            balanceRecords[index].balance.toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.red),
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "\$" +
                                        account[0]
                                            .accountBalance!
                                            .toStringAsFixed(2),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Balance",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          // Container(
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         account[0].order.toString(),
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(
                          //           fontSize: 20,
                          //         ),
                          //       ),
                          //       Text(
                          //         "Orders",
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(color: Colors.black54),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Expanded(child: Container()),
                        ],
                      ),
                      Divider(color: Colors.black),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView(
                          children: [
                            ListTile(
                              leading: Icon(Icons.attach_money),
                              title: Text('Top Up'),
                              onTap: () {
                                navigateToTopUpPage(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.qr_code_scanner),
                              title: Text('Connect to POS'),
                              onTap: () {
                                navigateToScanQRCodePage(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.lock_open),
                              title: Text('Change Password'),
                              onTap: () {
                                navigateToChangePasswordPage(context);
                              },
                            ),
                            Divider(color: Colors.black),
                            ListTile(
                              leading: Icon(
                                Icons.power_settings_new,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Log out',
                                style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: Text(
                                      "Are you sure you want to log out?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                          child: Text('Log Out'),
                                          onPressed: () {
                                            account = [
                                              Account(
                                                accountID: '',
                                                accountFirstName: '',
                                                accountLastName: '',
                                                // accountIcon:
                                                //     'https://image-resizer.cwg.tw/resize/uri/https%3A%2F%2Fcw1.tw%2FCC%2Fimages%2Farticle%2F201710%2Farticle-59d1f2b06a7a2.jpg/?w=810&h=543&fit=fill',
                                                accountRole: '',
                                                accountPhone: '',
                                                accountEmail: '',
                                                accountBirthday: "",
                                                accountPassword: "",
                                                accountGender: "",
                                                accountBalance: 0,
                                                order: 0,
                                                point: 0,
                                              ),
                                            ];
                                            login = 0;
                                            Fluttertoast.showToast(
                                                msg: "Log Out Successful");
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          }),
                                    ],
                                  ),
                                );
                                // appBarTitle = "productList";
                                // Update the state of the app
                                // ...
                                // Then close the drawer
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

        // body:
        // ElevatedButton(onPressed: (){
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
        // }, child: Text("haha"),),
      ),
    );
  }
}
