import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:member/Var/natigate.dart';
import 'package:string_validator/string_validator.dart';

import '../Var/var.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}


class EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<bool> isValid = [true, true, true, true];
  SingingCharacter? _gender = SingingCharacter.male;
  TextEditingController dateCtl = TextEditingController(text: userBirthday);
  String editFirstName = "";
  String editLastName = "";
  String editEmail = "";
  String editPhone = "";
  String editBirthday = "";
  String editGender = userGender;

  Widget build(BuildContext context) {
    if (editGender == "female") {
      _gender = SingingCharacter.female;
    } else if (editGender == "male") {
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (isAlpha(value!)) {
                      isValid[0] = true;
                      return null;
                    } else {
                      isValid[0] = false;
                      return "Invalid Name";
                    }
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (isAlpha(value!)) {
                      isValid[1] = true;
                      return null;
                    } else {
                      isValid[1] = false;
                      return "Invalid Name";
                    }
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (isEmail(value!)) {
                      isValid[2] = true;
                      return null;
                    } else {
                      isValid[2] = false;
                      return "Invalid Email Address";
                    }
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
                  keyboardType: TextInputType.number,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (isNumeric(value!)) {
                      if (value.length == 8) {
                        isValid[3] = true;
                        return null;
                      } else {
                        isValid[3] = false;
                        return "Phone must be 8 digits";
                      }
                    } else {
                      isValid[3] = false;
                      return "Invalid Phone Number";
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(

                  controller: dateCtl,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    labelText: "Your Birthday",
                    hintText: "Ex. Insert your dob",
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now()))!;
                    String day = date.day.toString().length == 1 ? "0" + date.day.toString() : date.day.toString();
                    String month = date.month.toString().length == 1 ? "0" + date.month.toString() : date.month.toString();
                    dateCtl.text = day +
                        "/" +
                        month +
                        "/" +
                        date.year.toString();
                    editBirthday = dateCtl.text;
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
                            editGender = "male";
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
                            editGender = "female";
                            _gender = value;
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
                        if(isValid[0] && isValid[1] && isValid[2] && isValid[3]){
                          for (int i = 0; i < account.length; i++) {
                            print(account[i].accountID);
                            print(userID);
                            if (account[i].accountID == userID) {
                              if (editFirstName != "") {
                                account[i].accountFirstName = editFirstName;
                                userFirstName = editFirstName;
                              }
                              if (editLastName != "") {
                                account[i].accountLastName = editLastName;
                                userLastName = editLastName;
                              }
                              if (editEmail != "") {
                                account[i].accountEmail = editEmail;
                                userEmail = editEmail;
                              }
                              if (editPhone != "") {
                                account[i].accountPhone = editPhone;
                                userPhone = editPhone;
                              }
                              if (editBirthday != "") {
                                account[i].accountBirthday = editBirthday;
                                userBirthday = editBirthday;
                              }
                              userGender = editGender;
                            }
                          }
                          Fluttertoast.showToast(msg: "Profile Edit Successful.");
                          navigateToMyProfilePage(context);
                        } else {
                          String errMsg = "The following field(s) is invalid";
                          if(!isValid[0]){
                            errMsg += "\n- First Name";
                          }
                          if(!isValid[1]){
                            errMsg += "\n- Last Name";
                          }
                          if(!isValid[2]){
                            errMsg += "\n- Email";
                          }
                          if(!isValid[3]){
                            errMsg += "\n- Phone";
                          }
                          Fluttertoast.showToast(msg: errMsg);
                        }
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
