import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
String apiDomain = "http://api.chunon.me";
String oExecuteUrl = "";
String oID = "";
DateTime now = new DateTime.now();
enum SingingCharacter { male, female }
int login = 0;
double topupValue = 0;
String unknownIcon =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg";
String unknownName = "Login";
String? userID = account[0].accountID;
String? userIcon = unknownIcon;
String? userFirstName = account[0].accountFirstName;
String? userLastName = account[0].accountLastName;
String? role = account[0].accountRole;
String? userPhone = account[0].accountPhone;
String? userEmail = account[0].accountEmail;
String? userBirthday = account[0].accountBirthday;
String? userGender = account[0].accountGender;
String? userPw = account[0].accountPassword;
double? accountBalance = account[0].accountBalance;
int? order = account[0].order;
int? point = account[0].point;
var displayBalance = 1;
// int fav = 1;
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back),
//         ),

enum Status{
  loading, success, error
}
Status status = Status.loading;

class Account {
  String? accountID;
  String? accountFirstName;
  String? accountLastName;
  String? accountEmail;
  String? accountPassword;
  String? accountPhone;
  String? accountBirthday;
  double? accountBalance;
  String? accountGender;
  int? point;
  int? order;
  // List<Null>? invoice;
  String? accountRole;

  Account(
      {this.accountID,
        this.accountFirstName,
        this.accountLastName,
        this.accountEmail,
        this.accountPassword,
        this.accountPhone,
        this.accountBirthday,
        this.accountBalance,
        this.accountGender,
        this.point,
        this.order,
        // this.invoice,
        this.accountRole});

  Account.fromJson(Map<String, dynamic> json) {
    accountID = json['accountID'];
    accountFirstName = json['firstName'];
    accountLastName = json['lastName'];
    accountEmail = json['email'];
    accountPassword = json['password'];
    accountPhone = json['phoneNumber'];
    accountBirthday = json['birthday'];
    accountBalance = json['balance'];
    accountGender = json['gender'];
    point = json['point'];
    order = json['order'];
    // if (json['invoice'] != null) {
    //   invoice = <Null>[];
    //   json['invoice'].forEach((v) {
    //     invoice!.add(new Null.fromJson(v));
    //   });
    // }
    accountRole = json['role'];
  }
}

List<Account> account = [
  Account(
    accountID: '',
    accountFirstName: '',
    accountLastName: '',
    // accountIcon:
    //     'https://image-resizer.cwg.tw/resize/uri/https%3A%2F%2Fcw1.tw%2FCC%2Fimages%2Farticle%2F201710%2Farticle-59d1f2b06a7a2.jpg/?w=810&h=543&fit=fill',
    accountRole: '',
    accountPhone: '',
    accountEmail: '',
    accountBirthday: "",
    accountPassword: "",
    accountGender: "",
    accountBalance: 0,
    order: 0,
    point: 0,
  ),
];

class InvoiceList {
  String invoiceID;
  List productList;
  String date;
  String time;
  String paymentMethod;
  double totalPrice;
  String invoiceImage;
  bool request;

  InvoiceList({
    required this.invoiceID,
    required this.productList,
    required this.date,
    required this.time,
    required this.paymentMethod,
    required this.totalPrice,
    required this.invoiceImage,
    required this.request,
  });
}

List<InvoiceList> invoiceList = [
  InvoiceList(
      invoiceID: "20190721831",
      productList: ["2", "2", "2"],
      date: "2019/07/21",
      time: "11:01",
      paymentMethod: "Account Balance",
      totalPrice: 98.7,
      request: false,
      invoiceImage:
          "https://images.hktvmall.com/h0888001/427e4800fe055ca10b737d54e45ca60f787d3de5/h0888001_10060249_190315122522_01_515.jpg"),
  InvoiceList(
      invoiceID: "20190612001",
      productList: ["3", "4", "1"],
      date: "2019/06/12",
      time: "00:01",
      paymentMethod: "Account Balance",
      totalPrice: 167.4,
      request: false,
      invoiceImage:
          "https://hk.ulifestyle.com.hk/cms/images/event/w600/202111/20211129180351_1_2.png"),
];

class Invoices {
  String? invoiceID;
  String? accountID;
  String? payMethod;
  String? invoiceDateTime;
  double? finalPrice;
  double? oldPrice;
  int? qty;
  String? productImage;

  Invoices(
      {this.invoiceID,
        this.accountID,
        this.payMethod,
        this.invoiceDateTime,
        this.finalPrice,
        this.oldPrice,
        this.qty,
        this.productImage});

  Invoices.fromJson(Map<String, dynamic> json) {
    invoiceID = json['invoiceID'];
    accountID = json['accountID'];
    payMethod = json['payMethod'];
    invoiceDateTime = json['InvoiceDateTime'];
    finalPrice = json['finalPrice'];
    oldPrice = json['oldPrice'];
    qty = json['qty'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoiceID'] = this.invoiceID;
    data['accountID'] = this.accountID;
    data['payMethod'] = this.payMethod;
    data['InvoiceDateTime'] = this.invoiceDateTime;
    data['finalPrice'] = this.finalPrice;
    data['oldPrice'] = this.oldPrice;
    data['qty'] = this.qty;
    data['productImage'] = this.productImage;
    return data;
  }
}

class Product {
  String productID;
  String productName;
  // String ProductDescription;
  double sellPrice;
  // double cost;
  double retailPrice;
  String productImage;
  // String productStatus;
  int fav;

  Product({
    required this.productID,
    required this.productName,
    // required this.ProductDescription,
    required this.sellPrice,
    // required this.cost,
    required this.retailPrice,
    required this.productImage,
    // required this.productStatus,
    required this.fav,
  });
}

List<Product> product = [
  Product(
    productID: '1',
    productName: 'Coca-Cola Zero (330ml X 8)',
    productImage:
        'https://images.hktv-img.com/images/HKTV/15953/400285_main_73896179_20210920110521_01_1200.jpg',
    fav: 1,
    retailPrice: 48,
    sellPrice: 34.4,
  ),
  Product(
    productID: '2',
    productName: 'Laurier - Anti-Bacterial Ultra Slim Night 30cm',
    productImage:
        'https://images.hktvmall.com/h0888001/427e4800fe055ca10b737d54e45ca60f787d3de5/h0888001_10060249_190315122522_01_515.jpg',
    fav: 1,
    retailPrice: 34.9,
    sellPrice: 32.9,
  ),
  Product(
    productID: '3',
    productName: 'COOL Water 750ml',
    productImage:
        'https://hk.ulifestyle.com.hk/cms/images/event/w600/202111/20211129180351_1_2.png',
    fav: 1,
    retailPrice: 6,
    sellPrice: 4,
  ),
  Product(
    productID: '4',
    productName: 'LINDOR Milk Cornet',
    productImage:
        'http://images.hktvmall.com/h0888001/967376c97fb5b9399d8d64f87e9ee0122240ab80/h0888001_10137528_191121053206_01_1200.jpg',
    fav: 1,
    retailPrice: 184,
    sellPrice: 129,
  ),
  Product(
    productID: '5',
    productName: 'Trappist Dairy - Fresh Milk (Chilled) 236ml',
    productImage:
        'http://images.hktvmall.com/h1115001/260619/h1115001_10138104_200828031816_01_1200.jpg',
    fav: 1,
    retailPrice: 8,
    sellPrice: 6,
  ),
];

class Products {
  String? productID;
  String? productName;
  double? cost;
  double? retailPrice;
  String? productImage;
  int? productStatus;
  int? favouriteID;

  Products(
      {this.productID,
        this.productName,
        this.cost,
        this.retailPrice,
        this.productImage,
        this.productStatus,
        this.favouriteID});

  Products.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    cost = json['cost'];
    retailPrice = json['retailPrice'];
    productImage = json['productImage'];
    productStatus = json['productStatus'];
    favouriteID = json['favouriteID'];
  }

}

Status productsStatus = Status.loading;
Future<List<Products>> productsAPI(String id) async {
  productsStatus = Status.loading;
  final response = await http.post(
    Uri.parse('http://api.chunon.me/getProducts_moblie'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"accountID": id})
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    productsStatus = Status.success;
    // List b = jsonDecode(response.body);
    // print(b);
    List<Products> myModels = (jsonDecode(response.body) as List)
        .map((i) => Products.fromJson(i))
        .toList();
    print(myModels);
    return myModels;
  } else {
    productsStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


class Branch {
  String? branchID;
  String? branchName;
  String? district;
  String? address;
  String? branchBusinessTime;

  Branch({
    this.branchID,
    this.branchName,
    this.district,
    this.address,
    this.branchBusinessTime
  });

  Branch.fromJson(Map<String, dynamic> json) {
    branchID = json['branchID'];
    branchName = json['branchName'];
    address = json['branchAddress'];
    branchBusinessTime = json['branchBusinessTime'];
    district = json['branchDistrict'];
  }
}

Status branchstatus = Status.loading;
Future<List<Branch>> branchAPI() async {
  branchstatus = Status.loading;
  final response = await http.post(
    Uri.parse('http://api.chunon.me/getBranch'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    branchstatus = Status.success;
    // List b = jsonDecode(response.body);
    // print(b);
    List<Branch> myModels = (jsonDecode(response.body) as List)
        .map((i) => Branch.fromJson(i))
        .toList();
    print(myModels);
    return myModels;
  } else {
    branchstatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

bool passwordValidation(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{0,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

void loadingScreen(BuildContext context){
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.9),
      content: Container(
        // color: Colors.grey,
        height:
        MediaQuery.of(context).size.height * .2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(color: Colors.deepPurpleAccent,),
            SizedBox(height: 25,),
            Text(
              "Loading",
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}


Future<Account> updateAccountAPI(String id) async {
  status = Status.loading;
  print(id);
  final response = await http.post(
    Uri.parse('$apiDomain/getMemberRecord'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"accountID": id}),
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