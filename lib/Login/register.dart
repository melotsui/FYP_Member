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
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Account> RegisterAPI(Account acc) async {
  status = Status.loading;
  final response = await http.post(
    Uri.parse('$apiDomain/insertMember'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "firstName": acc.accountFirstName,
      "lastName": acc.accountLastName,
      "email": acc.accountEmail,
      "password": acc.accountPassword,
      "phoneNumber": acc.accountPhone,
      "birthday": acc.accountBirthday,
      "gender": acc.accountGender,
      "passcode": acc.passcode
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    status = Status.success;
    return Account.fromJson(jsonDecode(response.body));
  } else {
    status = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get');
  }
}

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

// List<Account> newAccount = [];
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);

class RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SingingCharacter? _gender = SingingCharacter.male;
  TextEditingController dateCtl = TextEditingController(text: "");
  List<bool> isValid = [false, false, false, false, false, false, false];
  String newID = "";
  String newFirstName = "";
  String newLastName = "";
  String newEmail = "";
  String newPhone = "";
  String newBirthday = "";
  String newGender = "male";
  String image = "";
  String newPw = "";
  String newConfirmPw = "";
  String passcode = "";

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
                      isValid[0] = true;
                      return null;
                    } else {
                      isValid[0] = false;
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
                      isValid[1] = true;
                      return null;
                    } else {
                      isValid[1] = false;
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
                      isValid[2] = true;
                      return null;
                    } else {
                      isValid[2] = false;
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
                  keyboardType: TextInputType.number,
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
                        date.year.toString() + "-" + month + "-" + day;
                    newBirthday = dateCtl.text;
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
                        isValid[4] = false;
                        return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                      } else {
                        if (value.length < 8 || !passwordValidation(value)) {
                          isValid[4] = false;
                          if (value.length < 8) {
                            return "Equal to or more than 8 letters and digits";
                          }
                          if (!passwordValidation(value)) {
                            return "Must have uppercase and lowercase and digit";
                          }
                        } else {
                          isValid[4] = true;
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
                    labelText: 'Confirm Password',
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
                        isValid[5] = false;
                        return "Equal to or more than 8 letters and digits\nMust have uppercase and lowercase and digit";
                      } else {
                        isValid[5] = false;
                        if (value.length < 8 || !passwordValidation(value)) {
                          if (value.length < 8) {
                            return "Equal to or more than 8 letters and digits";
                          }
                          if (!passwordValidation(value)) {
                            return "Must have uppercase and lowercase and digit";
                          }
                        } else {
                          isValid[5] = true;
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
                  // initialValue: userPhone,
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
                        isValid[6] = true;
                        return null;
                      } else {
                        isValid[6] = false;
                        return "Phone must be 6 digits";
                      }
                    } else {
                      isValid[6] = false;
                      return "Invalid Passcode";
                    }
                  },
                  onChanged: (String? value) {
                    if (value != null) {
                      passcode = value;
                      print(passcode);
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
                        if (isValid[0] &&
                            isValid[1] &&
                            isValid[2] &&
                            isValid[3] &&
                            isValid[4] &&
                            isValid[5] &&
                            isValid[6]) {
                          if (newConfirmPw != newPw) {
                            Fluttertoast.showToast(
                                msg:
                                    "Confirm Password should be equal to Password.");
                          } else {
                            if (newBirthday == "") {
                              Fluttertoast.showToast(
                                  msg: "Birthday can not be null.");
                            } else {
                              if (image == "") {
                                image = unknownIcon;
                              }
                              print(newBirthday);
                              Account newAccount =
                                Account(
                                  accountID: newID,
                                  accountFirstName: newFirstName,
                                  accountLastName: newLastName,
                                  // accountIcon: image, //image path
                                  accountRole: 'VIP Member',
                                  accountPhone: newPhone,
                                  accountEmail: newEmail,
                                  accountPassword: newPw,
                                  accountBirthday: newBirthday,
                                  accountGender: newGender,
                                  passcode: passcode,
                                  accountBalance: 0,
                                  // order: 0,
                                  point: 0);
                              account = [];
                              RegisterAPI(newAccount).then((value) {
                                loadingScreen(context);
                                if (status == Status.success) {
                                  if(value.error == null){
                                    print("value.accountID.toString()" + value.accountID.toString());
                                    status = Status.loading;
                                    account.add(value);
                                    Future.delayed(Duration(milliseconds: 500),
                                            () {
                                          Fluttertoast.showToast(msg: "Account Created.");
                                          navigateToMyProfilePage(context);
                                        });
                                  } else {
                                    Fluttertoast.showToast(msg: value.error.toString());
                                    Navigator.pop(context);
                                  }
                                }
                              });
                            }
                          }
                        } else {
                          List<String> errMsg = [
                            "The following field(s) is invalid:"
                          ];
                          if (!isValid[0]) {
                            // Fluttertoast.showToast(msg: "First Name can not be null.");
                            errMsg.add("\n- First Name");
                          }
                          if (!isValid[1]) {
                            // Fluttertoast.showToast(msg: "Last Name can not be null.");
                            errMsg.add("\n- Last Name");
                          }
                          if (!isValid[2]) {
                            // Fluttertoast.showToast(msg: "Email can not be null.");
                            errMsg.add("\n- Email");
                          }
                          if (!isValid[3]) {
                            // Fluttertoast.showToast(msg: "Phone can not be null.");
                            errMsg.add("\n- Phone Number");
                          }
                          if (!isValid[4]) {
                            // Fluttertoast.showToast(msg: "Password can not be null.");
                            errMsg.add("\n- Password");
                          }
                          if (newBirthday == "") {
                            errMsg.add("\n- Birthday");
                          }
                          if (!isValid[5]) {
                            // Fluttertoast.showToast(msg: "Confirm Password can not be null.");
                            errMsg.add("\n- Confirm Password");
                          }
                          if (!isValid[6]) {
                            // Fluttertoast.showToast(msg: "Confirm Password can not be null.");
                            errMsg.add("\n- Passcode");
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
