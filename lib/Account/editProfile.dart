import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:member/Var/natigate.dart';

import '../Var/var.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}


enum SingingCharacter { male, female }
SingingCharacter? _gender = SingingCharacter.male;

class EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String editFirstName = "";
  String editLastName = "";
  String editEmail = "";
  String editPhone = "";
  String editBirthday = "";

  Widget build(BuildContext context) {
    if(userGender == "female"){
      _gender = SingingCharacter.female;
    } else if(userGender == "male"){
      _gender = SingingCharacter.male;
    }
    return Scaffold(
      appBar: new AppBar(
        title: Text("Edit My Profile"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                child: TextFormField(
                  initialValue: userFirstName,
                  style: TextStyle(fontSize: 20),
                  scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'First Name',

                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      editFirstName = value;
                      print(editFirstName);
                    }
                  },
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
                  initialValue: userLastName,
                  style: TextStyle(fontSize: 20),
                  scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      editLastName = value;
                      print(editLastName);
                    }
                  },
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
                  initialValue: userEmail,
                  style: TextStyle(fontSize: 20),
                  scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      editEmail = value;
                      print(editEmail);
                    }
                  },
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
                  initialValue: userPhone,
                  style: TextStyle(fontSize: 20),
                  scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      editPhone = value;
                      print(editPhone);
                    }
                  },
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
                  initialValue: userBirthday,
                  style: TextStyle(fontSize: 20),
                  scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: 'dd/mm/yyyy',
                    labelText: 'Your Birthday',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      editBirthday = value;
                      print(editBirthday);
                    }
                  },
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
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Text(
                        "Gender",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: (MediaQuery.of(context).size.width - 110),
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text('Male'),
                      horizontalTitleGap: 0,
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.male,
                        groupValue: _gender,
                        onChanged: (SingingCharacter? value) {
                          print(value);
                          setState(() {
                            userGender = "male";
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      horizontalTitleGap: 0,
                      title: Text('Female'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.female,
                        groupValue: _gender,
                        onChanged: (SingingCharacter? value) {
                          print(value);
                          setState(() {
                            userGender = "female";
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
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
                        for(int i=0; i<account.length; i++){
                          print(account[i].accountID);
                          print(userID);
                          if(account[i].accountID == userID){
                            if(editFirstName!=""){
                              account[i].accountFirstName = editFirstName;
                              userFirstName = editFirstName;
                            }
                            if(editLastName!=""){
                              account[i].accountLastName = editLastName;
                              userLastName = editLastName;
                            }
                            if(editEmail!=""){
                              account[i].accountEmail = editEmail;
                              userEmail = editEmail;
                            }
                            if(editPhone!=""){
                              account[i].accountPhone = editPhone;
                              userPhone = editPhone;
                            }
                            if(editBirthday!=""){
                              account[i].accountBirthday = editBirthday;
                              userBirthday = editBirthday;
                            }
                          }
                        }
                        navigateToMyProfilePage(context);
                        // login = 1;
                        // setState(() {});
                        // navigateToMyProfilePage(context);
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
      ),
    );
  }
}
