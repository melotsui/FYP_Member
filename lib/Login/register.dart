import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Var/natigate.dart';
import '../Var/var.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

enum SingingCharacter { male, female }
SingingCharacter? _gender = SingingCharacter.male;

// List<Account> newAccount = [];
var formatter = new DateFormat('yyyyMMdd');
String formattedDate = formatter.format(now);
String newID = "";
String newFirstName = "";
String newLastName = "";
String newEmail = "";
String newPhone = "";
String newBirthday = "";
String newGender = "";

class RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    print(newFirstName);
    print(formattedDate);
    for (int i = 1; i <= account.length + 1; i++) {
      if (i.toString().length == 1) {
        newID = formattedDate + "00" + i.toString();
      } else if (i.toString().length == 2) {
        newID = formattedDate + "0" + i.toString();
      } else if (i.toString().length == 3) {
        newID = formattedDate + "" + (account.length + 1).toString();
      }
      print(newID);
    }

    return Scaffold(
      appBar: new AppBar(
        title: Text("Register"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                child: TextFormField(
                  // initialValue: userFirstName,
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
                      newFirstName = value;
                      print(newFirstName);
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  // initialValue: userLastName,
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
                      newLastName = value;
                      print(newLastName);
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  // initialValue: userEmail,
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
                      newEmail = value;
                      print(newEmail);
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  // initialValue: userPhone,
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
                      newPhone = value;
                      print(newPhone);
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  // initialValue: userBirthday,
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
                      newBirthday = value;
                      print(newBirthday);
                    }
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
                            // userGender = "male";
                            _gender = value;
                            newGender = "male";
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
                            // userGender = "female";
                            _gender = value;
                            newGender = "female";
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
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
                        List<Account> newAccount = [
                          Account(
                            accountID: newID,
                            accountFirstName: newFirstName,
                            accountLastName: newLastName,
                            accountIcon: unknownIcon,
                            accountRole: 'VIP Member',
                            accountPhone: newPhone,
                            accountEmail: newEmail,
                            accountBirthday: newBirthday,
                            accountGender: newGender,
                            accountBalance: 0,
                            order: 0,
                            point: 0,
                          ),
                        ];
                        account.add(newAccount[0]);
                        navigateToLoginPage(context);
                        // login = 1;
                        // setState(() {});
                        // navigateToMyProfilePage(context);
                      },
                      child: Text(
                        'REGISTER',
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
