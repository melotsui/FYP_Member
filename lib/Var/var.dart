
import 'package:flutter/cupertino.dart';

int login = 0;
String unknownIcon = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg";
String unknownName = "Login";
String userIcon = account[0].accountIcon;
String userName = account[0].accountName;
String role = account[0].accountRole;
String userTel = account[0].accountPhone;
String accountEmail = account[0].accountEmail;
double accountBalance = account[0].accountBalance;
int order = account[0].order;
int point = account[0].point;
var displayBalance = 1;
// int fav = 1;
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back),
//         ),

class Account {
  String accountID;
  String accountName;
  String accountIcon;
  String accountRole;
  String accountPhone;
  String accountEmail;
  double accountBalance;
  int order;
  int point;

  Account({
    required this.accountID,
    required this.accountName,
    required this.accountIcon,
    required this.accountRole,
    required this.accountPhone,
    required this.accountEmail,
    required this.accountBalance,
    required this.order,
    required this.point,
  });
}

List<Account> account = [
  Account(
    accountID: '1',
    accountName: 'Melo Tsui',
    accountIcon: 'https://image-resizer.cwg.tw/resize/uri/https%3A%2F%2Fcw1.tw%2FCC%2Fimages%2Farticle%2F201710%2Farticle-59d1f2b06a7a2.jpg/?w=810&h=543&fit=fill',
    accountRole: 'VIP Member',
    accountPhone: '51581556',
    accountEmail: 'melotsui@gmail.com',
    accountBalance: 80.2,
    order: 12,
    point: 842,
  ),
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
    productImage: 'https://images.hktv-img.com/images/HKTV/15953/400285_main_73896179_20210920110521_01_1200.jpg',
    fav: 1,
    retailPrice: 48,
    sellPrice: 34.4,
  ),
  Product(
    productID: '2',
    productName: 'Laurier - Anti-Bacterial Ultra Slim Night 30cm',
    productImage: 'https://images.hktvmall.com/h0888001/427e4800fe055ca10b737d54e45ca60f787d3de5/h0888001_10060249_190315122522_01_515.jpg',
    fav: 1,
    retailPrice: 34.9,
    sellPrice: 32.9,
  ),
  Product(
    productID: '3',
    productName: 'COOL Water 750ml',
    productImage: 'https://hk.ulifestyle.com.hk/cms/images/event/w600/202111/20211129180351_1_2.png',
    fav: 1,
    retailPrice: 6,
    sellPrice: 4,
  ),
  Product(
    productID: '4',
    productName: 'LINDOR Milk Cornet',
    productImage: 'http://images.hktvmall.com/h0888001/967376c97fb5b9399d8d64f87e9ee0122240ab80/h0888001_10137528_191121053206_01_1200.jpg',
    fav: 1,
    retailPrice: 184,
    sellPrice: 129,
  ),
  Product(
    productID: '5',
    productName: 'Trappist Dairy - Fresh Milk (Chilled) 236ml',
    productImage: 'http://images.hktvmall.com/h1115001/260619/h1115001_10138104_200828031816_01_1200.jpg',
    fav: 1,
    retailPrice: 8,
    sellPrice: 6,
  ),
];