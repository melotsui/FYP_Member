import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Var/natigate.dart';
import '../Var/var.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import 'package:string_validator/string_validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

// List<Account> newAccount = [];
var formatter = new DateFormat('yyyyMMdd');
String formattedDate = formatter.format(now);

class RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SingingCharacter? _gender = SingingCharacter.male;
  TextEditingController dateCtl = TextEditingController(text: "");
  String newID = "";
  String newFirstName = "";
  String newLastName = "";
  String newEmail = "";
  String newPhone = "";
  String newBirthday = "";
  String newGender = "";
  String image = "";
  String newPw = "";
  String newConfirmPw = "";

  Widget build(BuildContext context) {
    final _picker = ImagePicker();
    Future<void> _imgFromGallery() async {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null)
        setState(() {
          // image = pickedImage;
        });
      print(pickedImage!.path);
      image = pickedImage.path;
    }

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
                    // helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'First Name',

                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (isAlpha(value!)) {
                      return null;
                    } else {
                      return "Invalid Name";
                    }
                  },
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
                    // helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  // validator: (String? value) {
                  //   return (value != null && value.contains('@'))
                  //       ? 'Do not use the @ char.'
                  //       : null;
                  // },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (isAlpha(value!)) {
                      return null;
                    } else {
                      return "Invalid Name";
                    }
                  },
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
                    // helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (isEmail(value!)) {
                      return null;
                    } else {
                      return "Invalid Email Address";
                    }
                  },
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
                    // helperText: 'Assistive text',
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (isNumeric(value!)) {
                      if (value.length == 8) {
                        return null;
                      } else {
                        return "Phone must be 8 digits";
                      }
                    } else {
                      return "Invalid Phone Number";
                    }
                  },
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
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      newPw = value;
                      print(newPw);
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value != null) {
                      if (!passwordValidation(value) && value.length < 8) {
                        return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                      } else {
                        if (value.length < 8 || !passwordValidation(value)) {
                          if (value.length < 8) {
                            return "Equal to or more than 8 letters and digits";
                          }
                          if (!passwordValidation(value)) {
                            return "Must have uppercase and lowercase and digit";
                          }
                        } else {
                          return null;
                        }
                      }
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  scrollPadding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    // icon: Icon(Icons.person),
                    hintText: '',
                    labelText: 'ConfirmPassword',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      newConfirmPw = value;
                      print(newConfirmPw);
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value != null) {
                      if (!passwordValidation(value) && value.length < 8) {
                        return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                      } else {
                        if (value.length < 8 || !passwordValidation(value)) {
                          if (value.length < 8) {
                            return "Equal to or more than 8 letters and digits";
                          }
                          if (!passwordValidation(value)) {
                            return "Must have uppercase and lowercase and digit";
                          }
                        } else {
                          return null;
                        }
                      }
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
                    hintText: "",
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

                    String day = date.day.toString().length == 1
                        ? "0" + date.day.toString()
                        : date.day.toString();
                    String month = date.month.toString().length == 1
                        ? "0" + date.month.toString()
                        : date.month.toString();
                    dateCtl.text =
                        day + "/" + month + "/" + date.year.toString();
                    newBirthday = dateCtl.text;
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
              GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Upload_alt_font_awesome.svg/100px-Upload_alt_font_awesome.svg.png"),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onTap: () {
                    _imgFromGallery();
                  }),
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
                        if (newFirstName != "" &&
                            newLastName != "" &&
                            newPhone != "" &&
                            newEmail != "" &&
                            newPw != "" &&
                            newConfirmPw != "" &&
                            newBirthday != "") {
                          if (newConfirmPw != newPw) {
                            Fluttertoast.showToast(
                                msg:
                                    "Confirm Password should be equal to Password.");
                          } else {
                            if (image == "") {
                              image = unknownIcon;
                            }
                            List<Account> newAccount = [
                              Account(
                                accountID: newID,
                                accountFirstName: newFirstName,
                                accountLastName: newLastName,
                                accountIcon: image, //image path
                                accountRole: 'VIP Member',
                                accountPhone: newPhone,
                                accountEmail: newEmail,
                                accountPassword: newPw,
                                accountBirthday: newBirthday,
                                accountGender: newGender,
                                accountBalance: 0,
                                order: 0,
                                point: 0,
                              ),
                            ];
                            account.add(newAccount[0]);
                            navigateToLoginPage(context);
                          }
                        } else {
                          List<String> errMsg = [
                            "The following field(s) cannot be null:"
                          ];
                          if (newFirstName == "") {
                            // Fluttertoast.showToast(msg: "First Name can not be null.");
                            errMsg.add("\n- First Name");
                          }
                          if (newLastName == "") {
                            // Fluttertoast.showToast(msg: "Last Name can not be null.");
                            errMsg.add("\n- Last Name");
                          }
                          if (newEmail == "") {
                            // Fluttertoast.showToast(msg: "Email can not be null.");
                            errMsg.add("\n- Email");
                          }
                          if (newPhone == "") {
                            // Fluttertoast.showToast(msg: "Phone can not be null.");
                            errMsg.add("\n- Phone Number");
                          }
                          if (newPw == "") {
                            // Fluttertoast.showToast(msg: "Password can not be null.");
                            errMsg.add("\n- Password");
                          }
                          if (newConfirmPw == "") {
                            // Fluttertoast.showToast(msg: "Confirm Password can not be null.");
                            errMsg.add("\n- Confirm Password");
                          }
                          if (newBirthday == "") {
                            // Fluttertoast.showToast(msg: "Birthday can not be null.");
                            errMsg.add("\n- Birthday");
                          }
                          String toString = "";
                          for (int i = 0; i < errMsg.length; i++) {
                            toString += errMsg[i];
                          }
                          Fluttertoast.showToast(msg: toString);
                        }
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

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

// bool isNumeric(String s) {
//   if (s == null) {
//     return false;
//   }
//   return int.tryParse(s) != null;
// }

bool isNull(String s) {
  if (s == "") {
    return false;
  }
  return true;
}
