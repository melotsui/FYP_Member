import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Paypal/PaypalPayment.dart';
import 'package:member/Var/natigate.dart';
import 'package:member/Var/var.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Account/profile.dart';
import '../Login/login.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';

Future<TopupStatus> topupAPI(String id, double addValue) async {
  status = Status.loading;
  final response = await http.post(
    Uri.parse('$apiDomain/updateMemberBalance'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"accountID": id, "addBalance": addValue, "isAdd": 1, "payMethod": "Paypal"}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    status = Status.success;
    return TopupStatus.fromJson(jsonDecode(response.body));
  } else {
    status = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to topup');
  }
}

class TopupStatus {
  String? success;

  TopupStatus({this.success});

  TopupStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}

class TopUpPage extends StatefulWidget {
  @override
  TopUpPageState createState() => TopUpPageState();
}

bool isValid = false;

class TopUpPageState extends State<TopUpPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topupValue = 0;
    isValid = false;
    updateAccountAPI(account[0].accountID.toString()).then((value) {
      account = [];
      account.add(value);
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyProfilePage()),
            (Route<dynamic> route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          title: Text("Top Up"),
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MyProfilePage()),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: status == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              )
            : Container(
                margin: new EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: Text("")),
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: GestureDetector(
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: account[0].image != null
                                  ? NetworkImage(apiDomain + account[0].image.toString())
                                  : NetworkImage(unknownIcon),
                            ),
                            onTap: () {
                              // navigateToIconPage(context);
                            },
                          ),
                        ),
                        Expanded(child: Text("")),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 0),
                          child: Text(
                            "Account Balance",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, left: 0),
                          child: Text(
                            "HKD " + account[0].accountBalance!.toStringAsFixed(2),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        // initialValue: userPhone,
                        autofocus: true,
                        style: TextStyle(fontSize: 20),
                        scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          // helperText: 'Assistive text',
                          // icon: Icon(Icons.person),

                          hintText: '',
                          labelText: 'HKD',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (isValid) {
                            return null;
                          } else {
                            return "Invalid Value";
                          }
                        },
                        onChanged: (String? value) {
                          if (value != null) {
                            try {
                              topupValue = double.parse(value);
                              print(topupValue);
                              isValid = true;
                            } on Exception catch (ex) {
                              isValid = false;
                            }
                          }
                        },
                      ),
                    ),
                    Expanded(child: Text("")),
                    Row(
                      children: <Widget>[
                        Expanded(child: Text("")),
                        Text("Available to top up from Paypal"),
                        Expanded(child: Text("")),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {
                              if (isValid) {
                                if(topupValue > 0){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaypalPayment(
                                            onFinish: (number) async {
                                              // payment done
                                              // if (oID != number) {
                                              oID = number;
                                              print("account[0].accountID" + account[0].accountID!);
                                              topupAPI(account[0].accountID!, topupValue)
                                                  .then((value) {
                                                loadingScreen(context);
                                                if (status == Status.success) {
                                                  double x =
                                                      accountBalance! + topupValue;
                                                  accountBalance = x;
                                                  print(
                                                      'accountBalance: $accountBalance');
                                                  for (int i = 0;
                                                  i < account.length;
                                                  i++) {
                                                    if (account[i].accountID ==
                                                        userID) {
                                                      account[i].accountBalance =
                                                          accountBalance;
                                                    }
                                                  }
                                                  Fluttertoast.showToast(
                                                      msg: "Top Up Successful");

                                                  Future.delayed(
                                                      Duration(milliseconds: 1000),
                                                          () {
                                                        navigateToMyProfilePage(context);
                                                      });
                                                }
                                              });
                                              print('order id: ' + number);
                                              // }
                                            },
                                          ),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Top Up Value cannot be Zero!");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Invalid Top Up Value");
                              }
                            },
                            child: Text(
                              'Top Up',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
