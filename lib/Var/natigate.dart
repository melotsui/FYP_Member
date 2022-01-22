import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Account/profile.dart';
import '../Login/register.dart';

void navigateToRegisterPage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => RegisterPage()));
}

void navigateToProfilePage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => AccountPage()));
}