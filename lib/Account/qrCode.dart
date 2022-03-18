import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:member/Account/profile.dart';
import 'package:member/Var/natigate.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCodePage extends StatefulWidget {
  @override
  ScanQRCodePageState createState() => ScanQRCodePageState();
}

class ScanQRCodePageState extends State<ScanQRCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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
      setState(() {
        result = scanData;
        print(result!.code.toString());
        navigateToMyProfilePage(context);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
