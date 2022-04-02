import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Product/productList.dart';
import 'package:member/Var/natigate.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

Future<List<FavProducts>> favProductsAPI(String id) async {
  productsStatus = Status.loading;
  final response =
      await http.post(Uri.parse('http://api.chunon.me/getFavourite_moblie'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"accountID": id}));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    productsStatus = Status.success;
    // List b = jsonDecode(response.body);
    // print(b);
    List<FavProducts> myModels = (jsonDecode(response.body) as List)
        .map((i) => FavProducts.fromJson(i))
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

class FavProducts {
  String? productID;
  String? productName;
  String? productDescription;
  double? sellPrice;
  double? cost;
  double? retailPrice;
  String? productImage;
  int? productStatus;
  int? favouriteID;

  FavProducts(
      {this.productID,
      this.productName,
      this.productDescription,
      this.sellPrice,
      this.cost,
      this.retailPrice,
      this.productImage,
      this.productStatus,
      this.favouriteID});

  FavProducts.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    sellPrice = json['sellPrice'];
    cost = json['cost'];
    retailPrice = json['retailPrice'];
    productImage = json['productImage'];
    productStatus = json['productStatus'];
    favouriteID = json['favouriteID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['sellPrice'] = this.sellPrice;
    data['cost'] = this.cost;
    data['retailPrice'] = this.retailPrice;
    data['productImage'] = this.productImage;
    data['productStatus'] = this.productStatus;
    data['favouriteID'] = this.favouriteID;
    return data;
  }
}

class FavouriteProductPage extends StatefulWidget {
  String accountID;
  FavouriteProductPage({Key? key, required this.accountID}) : super(key: key);
  @override
  FavouriteProductPageState createState() => FavouriteProductPageState();
}

List searchProduct = product;
List favProduct = [];
List<FavProducts> favProducts = [];
List<FavProducts> searchProducts = [];

class FavouriteProductPageState extends State<FavouriteProductPage> {
  FlutterSecureStorage storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < product.length; i++) {
      if (product[i].fav % 2 == 0) {
        favProduct.add(product[i]);
      }
    }
    searchProduct = favProduct;
    super.initState();
    favProductsAPI(account[0].accountID.toString()).then((value) {
      favProducts = [];
      favProducts = value;
      searchProducts = favProducts;
      setState(() {});
    });
    searchProducts = favProducts;
    print("searchProducts.length: " + searchProducts.length.toString());
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigateToProductListPage(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Favourite Product"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ProductListPage()),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: productsStatus == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              )
            : favProducts.length > 0
                ? Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 10),
                        child: TextField(
                          // obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            labelText: 'Search Product',
                          ),
                          onChanged: (text) {
                            searchProducts = [];
                            print(searchProduct);
                            print(favProduct);
                            if (text != "") {
                              for (int i = 0; i < favProducts.length; i++) {
                                if (favProducts[i]
                                    .productName
                                    .toString()
                                    .toLowerCase()
                                    .contains(text.toLowerCase())) {
                                  searchProducts.add(favProducts[i]);
                                }
                              }
                            } else {
                              searchProducts = favProducts;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20),
                          itemCount: searchProducts.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                print(searchProducts[index]);
                                navigateToProductDetailPage(
                                    context, searchProduct[index], searchProducts[index].productID.toString());
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 60,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(child: SizedBox()),
                                          Expanded(
                                            flex: 5,
                                            child: Image(
                                              image: NetworkImage(apiDomain +
                                                  searchProducts[index]
                                                      .productImage
                                                      .toString()),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 30,
                                                  child: GestureDetector(
                                                    child: Icon(Icons.favorite,
                                                        color:
                                                            Colors.redAccent),
                                                    onTap: () {
                                                      deleteFavAPI(
                                                              account[0]
                                                                  .accountID
                                                                  .toString(),
                                                              searchProducts[
                                                                      index]
                                                                  .productID
                                                                  .toString())
                                                          .then((value) {
                                                        if (value.success ==
                                                                1 &&
                                                            productsStatus ==
                                                                Status
                                                                    .success) {
                                                          Fluttertoast.showToast(
                                                              msg: searchProducts[
                                                                          index]
                                                                      .productName
                                                                      .toString() +
                                                                  " is deleted from favourite list.");
                                                          navigateToFavouriteProductPage(
                                                              context,
                                                              account[0]
                                                                  .accountID
                                                                  .toString());
                                                        }
                                                      });
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 70,
                                                  child: SizedBox(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 40,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(child: Text("")),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    searchProducts[index]
                                                        .productName
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 60),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Expanded(child: Text("")),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  'HK\$' +
                                                      searchProducts[index]
                                                          .sellPrice
                                                          .toString() +
                                                      ' ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                searchProducts[index]
                                                            .retailPrice !=
                                                        searchProducts[index]
                                                            .sellPrice
                                                    ? Text(
                                                        'HK\$' +
                                                            searchProducts[
                                                                    index]
                                                                .retailPrice
                                                                .toString(),
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              196,
                                                              196,
                                                              196,
                                                              73),
                                                          fontSize: 13,
                                                        ),
                                                      )
                                                    : Text(""),
                                              ],
                                            ),
                                            Expanded(child: Text("")),
                                            Row(
                                              children: <Widget>[
                                                searchProducts[index]
                                                            .retailPrice !=
                                                        searchProducts[index]
                                                            .sellPrice
                                                    ? Text(
                                                        'Save \$' +
                                                            (searchProducts[index]
                                                                        .retailPrice! -
                                                                    searchProducts[
                                                                            index]
                                                                        .sellPrice!)
                                                                .toStringAsFixed(
                                                                    1) +
                                                            '!',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              214,
                                                              39,
                                                              218,
                                                              100),
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                    : Text(""),
                                              ],
                                            ),
                                            Expanded(child: Text("")),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.3),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: NetworkImage(
                    //             "https://www.pngrepo.com/download/348144/favourite.png"),
                    //         fit: BoxFit.contain)),
                    alignment: Alignment.center,
                    child: Text(
                      "You don't have any favourite product right now",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38),
                    ),
                  ),
        drawer: NavigationBarPageState().navBar(context),
      ),
    );
  }
}
