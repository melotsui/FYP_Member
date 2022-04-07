import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:member/Account/profile.dart';
import 'package:member/Var/natigate.dart';
import 'package:string_validator/string_validator.dart';

import '../Var/var.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<EditProfileStatus> editProfileAPI(String id, String fname, String lname, String phone, String gender, String passcode) async {
  status = Status.loading;
  final response = await http.post(
    Uri.parse('$apiDomain/updateMember'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "accountID": id,
      "firstName": fname,
      "lastName": lname,
      "phoneNumber": phone,
      "gender": gender,
      "passcode": passcode
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    status = Status.success;
    return EditProfileStatus.fromJson(jsonDecode(response.body));
  } else {
    status = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to Edit');
  }
}

class EditProfileStatus {
  String? success;

  EditProfileStatus({this.success});

  EditProfileStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  List<bool> isValid = [true, true, true, true];
  SingingCharacter? _gender = SingingCharacter.male;
  TextEditingController dateCtl = TextEditingController(text: account[0].accountBirthday);
  String editFirstName = "";
  String editLastName = "";
  String editEmail = "";
  String editPhone = "";
  String editBirthday = "";
  String? editGender = account[0].accountGender.toString();
  String editPasscode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateAccountAPI(account[0].accountID.toString()).then((value) {
      dateCtl = TextEditingController(text: value.accountBirthday.toString());
      editFirstName = value.accountFirstName.toString();
      editLastName = value.accountLastName.toString();
      editEmail = value.accountEmail.toString();
      editPhone = value.accountPhone.toString();
      editBirthday = value.accountBirthday.toString();
      editGender = value.accountGender.toString();
      editPasscode = value.passcode.toString();
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    if (editGender == "female") {
      _gender = SingingCharacter.female;
    } else if (editGender == "male") {
      _gender = SingingCharacter.male;
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyProfilePage()),
            (Route<dynamic> route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          title: Text("Edit My Profile"),
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
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        child: TextFormField(
                          initialValue: editFirstName,
                          style: TextStyle(fontSize: 20),
                          scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            // helperText: 'Assistive text',
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
                          initialValue: editLastName,
                          style: TextStyle(fontSize: 20),
                          scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            // helperText: 'Assistive text',
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
                          initialValue: editPhone,
                          style: TextStyle(fontSize: 20),
                          scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            // helperText: 'Assistive text',
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
                                isValid[2] = true;
                                return null;
                              } else {
                                isValid[2] = false;
                                return "Phone must be 8 digits";
                              }
                            } else {
                              isValid[2] = false;
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            labelText: "Your Birthday",
                            hintText: "Ex. Insert your dob",
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            DateTime date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            date = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now()))!;
                            String day = date.day.toString().length == 1
                                ? "0" + date.day.toString()
                                : date.day.toString();
                            String month = date.month.toString().length == 1
                                ? "0" + date.month.toString()
                                : date.month.toString();
                            dateCtl.text =
                                day + "/" + month + "/" + date.year.toString();
                            editBirthday = dateCtl.text;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          initialValue: editPasscode,
                          style: TextStyle(fontSize: 20),
                          scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            // helperText: 'Assistive text',
                            // icon: Icon(Icons.person),
                            hintText: '',
                            labelText: 'Passcode',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (isNumeric(value!)) {
                              if (value.length == 6) {
                                isValid[3] = true;
                                return null;
                              } else {
                                isValid[3] = false;
                                return "Phone must be 6 digits";
                              }
                            } else {
                              isValid[3] = false;
                              return "Invalid Passcode";
                            }
                          },
                          onChanged: (String? value) {
                            if (value != null) {
                              editPasscode = value;
                              print(editPasscode);
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
                                if (isValid[0] &&
                                    isValid[1] &&
                                    isValid[2] &&
                                    isValid[3]) {
                                  loadingScreen(context);
                                  // editProfileAPI
                                  editProfileAPI(account[0].accountID.toString(), editFirstName, editLastName, editPhone, editGender!, editPasscode).then((value) {
                                    if (status == Status.success) {
                                        status = Status.loading;
                                        Future.delayed(Duration(milliseconds: 500),
                                                () {
                                                  Fluttertoast.showToast(
                                                      msg: "Profile Edit Successful.");
                                                  navigateToMyProfilePage(context);
                                            });
                                    }
                                  });
                                } else {
                                  String errMsg =
                                      "The following field(s) is invalid";
                                  if (!isValid[0]) {
                                    errMsg += "\n- First Name";
                                  }
                                  if (!isValid[1]) {
                                    errMsg += "\n- Last Name";
                                  }
                                  if (!isValid[2]) {
                                    errMsg += "\n- Phone";
                                  }
                                  if (!isValid[3]) {
                                    errMsg += "\n- Passcode";
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
      ),
    );
  }
}
