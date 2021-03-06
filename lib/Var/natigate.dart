import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member/Account/qrCode.dart';
import 'package:member/Branch/branchList.dart';
import 'package:member/ForgetPassword/resetPassword.dart';
import 'package:member/NoticeBoard/noticeBoard.dart';
import 'package:member/Paypal/topup.dart';
import 'package:member/Var/var.dart';

import '../Account/changePassword.dart';
import '../Account/editProfile.dart';
import '../ForgetPassword/forgetPassword.dart';
import '../Account/icon.dart';
import '../Account/profile.dart';
import '../Invoice/invoiceDetail.dart';
import '../Invoice/invoiceList.dart';
import '../Login/login.dart';
import '../Login/register.dart';
import '../Product/favourite.dart';
import '../Product/productDetail.dart';
import '../Product/productList.dart';

// RegisterPage
void navigateToRegisterPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
}

// MyProfilePage
void navigateToMyProfilePage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyProfilePage()));
}

// ProductListPage
void navigateToProductListPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductListPage()));
}

// LoginPage
void navigateToLoginPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
}

// IconPage
void navigateToIconPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => IconPage()));
}

// ChangePasswordPage
void navigateToChangePasswordPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordPage()));
}

// InvoiceListPage
void navigateToInvoiceListPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvoiceListPage()));
}

// FavouriteProductPage
void navigateToFavouriteProductPage(BuildContext context, String accountID) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavouriteProductPage(accountID: accountID)));
}

// ProductDetailPage
void navigateToProductDetailPage(BuildContext context, String productID) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(productID: productID)));
}

// InvoiceDetailPage
void navigateToInvoiceDetailPage(BuildContext context, String invoiceID) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvoiceDetailPage(invoiceID: invoiceID)));
}

// EditProfilePage
void navigateToEditProfilePage(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage()));
}

// ForgetPasswordPage
void navigateToForgetPasswordPage(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPasswordPage()));
}

// ScanQRCodePage
void navigateToScanQRCodePage(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanQRCodePage()));
}

// TopUpPage
void navigateToTopUpPage(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TopUpPage()));
}

// BranchListPage
void navigateToBranchListPage(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BranchListPage()));
}

// NoticeBoardPage
void navigateToNoticeBoardPage(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoticeBoardPage()));
}

// ResetPasswordPage
void navigateToResetPasswordPage(BuildContext context, String id){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPasswordPage(id: id)));
}