import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
          Image(
            image: account[0].image != null
                ? NetworkImage(apiDomain + account[0].image.toString())
                : NetworkImage(unknownIcon),
            fit: BoxFit.contain,
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
