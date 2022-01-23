import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member/Var/var.dart';

import '../Account/icon.dart';
import '../Account/profile.dart';
import '../Invoice/invoiceList.dart';
import '../Login/login.dart';
import '../Login/register.dart';
import '../Product/favourite.dart';
import '../Product/productList.dart';

// RegisterPage
void navigateToRegisterPage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => RegisterPage()));
}

// MyProfilePage
void navigateToMyProfilePage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => MyProfilePage()));
}

// ProductListPage
void navigateToProductListPage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ProductListPage()));
}

// LoginPage
void navigateToLoginPage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => LoginPage()));
}

// IconPage
void navigateToIconPage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => IconPage()));
}

// ChangePasswordPage
// void navigateToChangePasswordPage(BuildContext context) {
//   Navigator.of(context)
//       .push(MaterialPageRoute(builder: (context) => ChangePasswordPage()));
// }

// InvoiceListPage
void navigateToInvoiceListPage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => InvoiceListPage()));
}

// FavouriteProductPage
void navigateToFavouriteProductPage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => FavouriteProductPage()));
}