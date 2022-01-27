import 'package:flutter/material.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Change Password"),
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30),
              child: TextFormField(
                obscureText: true,
                style: TextStyle(fontSize: 20),
                scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  helperText: 'Assistive text',
                  // icon: Icon(Icons.person),
                  hintText: '',
                  labelText: 'Old Password',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                obscureText: true,
                scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  helperText: 'Assistive text',
                  // icon: Icon(Icons.person),
                  hintText: '',
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                obscureText: true,
                scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  helperText: 'Assistive text',
                  // icon: Icon(Icons.person),
                  hintText: '',
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {

                    },
                    child: Text(
                      'SAVE',
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
    );
  }
}
