import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Account/profile.dart';
import 'package:member/Var/natigate.dart';
import 'package:member/Var/var.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<ScanQRCodeStatus> scanQRCodeAPI(String id, String uid) async {
  status = Status.loading;
  final response = await http.post(
    Uri.parse('$apiDomain/insertFirstLogin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"accountID": id, "uid": uid}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    status = Status.success;
    return ScanQRCodeStatus.fromJson(jsonDecode(response.body));
  } else {
    status = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to scan');
  }
}

class ScanQRCodeStatus {
  int? success;

  ScanQRCodeStatus({this.success});

  ScanQRCodeStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}

class ScanQRCodePage extends StatefulWidget {
  @override
  ScanQRCodePageState createState() => ScanQRCodePageState();
}

class ScanQRCodePageState extends State<ScanQRCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String uid = "";
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
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
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Scan QR Code"),
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
        body: Column(
          children: <Widget>[
            // Expanded(
            //   flex: 2,
            //   child: Center(
            //     child: (result != null)
            //         ? Text(
            //         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            //         : Text('Scan a code'),
            //   ),
            // ),
            Expanded(
              flex: 6,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            // Expanded(
            //   flex: 2,
            //   child: Center(
            //     child: (result != null)
            //         ? Text(
            //         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            //         : Text('Scan a code'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      print(result!.code.toString());
      if(uid != result!.code.toString()){
        uid = result!.code.toString();
        loadingScreen(context);
        scanQRCodeAPI(account[0].accountID.toString(), result!.code.toString())
            .then((value) {
          if (status == Status.success) {
            status = Status.loading;
            if (value.success == 1) {
              Future.delayed(Duration(milliseconds: 500), () {
                Fluttertoast.showToast(msg: "Connect Successful");
                navigateToMyProfilePage(context);
              });
            } else {
              Future.delayed(Duration(milliseconds: 500), () {
                Fluttertoast.showToast(
                    msg: "Please generate QRcode from POS again");
                Navigator.pop(context);
              });
            }
          }
        });
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
