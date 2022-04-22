import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:member/Var/natigate.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class IconPage extends StatefulWidget {
  @override
  IconPagePageState createState() => IconPagePageState();
}

class IconPagePageState extends State<IconPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // updateAccountAPI(account[0].accountID.toString()).then((value) {
    //   account = [];
    //   account.add(value);
    //   print(value.image.toString());
    //   print("PASSCODE " + account[0].passcode.toString());
    //   // if (account[0].passcode.toString() == "") {
    //   //   screenLock(context: context, canCancel: true, correctString: "");
    //   // }
    //   setState(() {});
    // });
  }

  File? uploadImage;

  Widget build(BuildContext context) {
    final _picker = ImagePicker();
    Future<void> _imgFromGallery() async {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null)
        setState(() {
          // image = pickedImage;
        });
      uploadImage = File(pickedImage!.path);
      print(uploadImage!.readAsBytes().asStream());
      print(account[0].accountID.toString());
      uploadImageAPI(account[0].accountID.toString(), uploadImage!)
          .then((value) {
        print(value.error.toString());
        print(value.success.toString());
        if (value.error == null) {
          setState(() {});
          Fluttertoast.showToast(msg: "Change Icon Successful");
          navigateToMyProfilePage(context);
        } else {
          Fluttertoast.showToast(msg: value.error.toString());
        }
      });
    }

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Icon"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _imgFromGallery();
            },
            icon: Icon(
              Icons.edit,
              // color: Colors.redAccent,
            ),
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
          : Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Container(
                  // height: MediaQuery.of(context).size.width,
                  // width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: account[0].image != null
                        ? NetworkImage(apiDomain + account[0].image.toString())
                        : NetworkImage(unknownIcon),
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
    );
  }
}
