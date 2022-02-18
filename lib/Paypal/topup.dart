import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Paypal/PaypalPayment.dart';
import 'package:member/Var/natigate.dart';
import 'package:member/Var/var.dart';
import 'package:string_validator/string_validator.dart';

import '../Login/login.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';

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
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Top Up"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
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
                      backgroundImage: login > 0
                          ? NetworkImage(userIcon)
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
                    "HKD " + accountBalance.toStringAsFixed(2),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaypalPayment(
                              onFinish: (number) async {
                                // payment done
                                print('order id: ' + number);
                              },
                            ),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(msg: "Invalid Top Up Value");
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
    );
  }
}
