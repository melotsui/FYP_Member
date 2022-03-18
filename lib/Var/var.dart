import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
String apiDomain = "http://api.chunon.me";
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
int? order = 2;
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
    // order: 2,
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

class Branch {
  String branchID;
  String branchName;
  int qty;
  String district;
  String address;

  Branch({
    required this.branchID,
    required this.branchName,
    required this.qty,
    required this.district,
    required this.address,
  });
}

List<Branch> branch = [
  Branch(
    branchID: "1",
    branchName: "Branch A",
    qty: 52,
    district: "NT",
    address: "Shop No. 1, G/F, Kwai Chung Shopping Centre, Kwai Chung Estate, Kwai Chung, N.T.",
  ),
  Branch(
    branchID: "2",
    branchName: "Branch B",
    qty: 68,
    district: "KLN",
    address: "G/F, Dr. Ng Tor Tai International House, 32 Renfrew Road, Kowloon Tong",
  ),
  Branch(
    branchID: "3",
    branchName: "Branch C",
    qty: 99,
    district: "HK",
    address: "2 Catchick Street, Kennedy Town",
  ),
];

bool passwordValidation(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{0,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
