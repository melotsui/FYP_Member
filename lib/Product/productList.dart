import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Var/natigate.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class ProductListPage extends StatefulWidget {
  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {
  FlutterSecureStorage storage = new FlutterSecureStorage();
  TextEditingController _searchTextController = new TextEditingController();
  DateTime? currentBackPressTime;
  List<Products> products = [];
  List searchProduct = product;
  List<Products> searchProducts = [];
  @override
  void initState() {
    // TODO: implement initState

    searchProduct = product;
    searchProducts = products;
    super.initState();
    print(account[0].accountID.toString());
    updateAccountAPI(account[0].accountID.toString()).then((value) {
      account = [];
      account.add(value);
      setState(() {});
    });
    productsAPI(account[0].accountID.toString()).then((value) {
      products = [];
      products = value;
      searchProducts = products;
      print(products[0].productName.toString());
      setState(() {});
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press one more time to close the app");

      return Future.value(false);
    }
    return exit(0);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Product List"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                if (login == 0) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Text(
                        "You have not login. \nDo you want to login?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'No'),
                          child: Text('No'),
                        ),
                        TextButton(
                            child: Text('Yes'),
                            onPressed: () {
                              navigateToLoginPage(context);
                            }),
                      ],
                    ),
                  );
                  // Fluttertoast.showToast(msg: "You have not login.");
                } else {
                  navigateToFavouriteProductPage(context);
                }
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        body: status == Status.loading || productsStatus == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              )
            : Column(
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
                        searchProduct = [];
                        searchProducts = [];
                        print(products);
                        if (text != "") {
                          for (int i = 0; i < products.length; i++){
                            print(products[i].productName.toString().toLowerCase() + ", " + text.toLowerCase());
                            print(products[i].productName.toString().toLowerCase().contains(text.toLowerCase()));
                            if(products[i].productName.toString().toLowerCase().contains(text.toLowerCase())){
                              print(products[i].productName.toString().toLowerCase());
                              searchProducts.add(products[i]);
                              print(searchProducts.length);
                            }
                          }
                          for (int i = 0; i < product.length; i++) {
                            if (product[i]
                                .productName
                                .toLowerCase()
                                .contains(text.toLowerCase())) {
                              searchProduct.add(product[i]);
                            }
                          }
                        } else {
                          searchProducts = products;
                          print(searchProducts.length.toString());
                          searchProduct = product;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20),
                      itemCount: searchProducts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () async {
                            print(searchProduct[index]);
                            navigateToProductDetailPage(
                                context, searchProduct[index]);
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            // padding: EdgeInsets.symmetric(horizontal: 10),
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
                                          image: NetworkImage(
                                              apiDomain + searchProducts[index]
                                                  .productImage.toString()),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 30,
                                              child: login > 0
                                                  ? GestureDetector(
                                                      child: searchProducts[index]
                                                                          .favouriteID !=
                                                                  null &&
                                                              login > 0
                                                          ? Icon(Icons.favorite,
                                                              color: Colors
                                                                  .redAccent)
                                                          : Icon(Icons
                                                              .favorite_border),
                                                      onTap: () {
                                                        if (login > 0 && searchProducts[index]
                                                            .favouriteID ==
                                                            null) {
                                                          addFavAPI(account[0].accountID.toString(), searchProducts[index].productID.toString()).then((value) {
                                                            if(value.success == 1){
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                  searchProducts[index].productName.toString() + " is added to favourite list.");
                                                              navigateToProductListPage(context);
                                                            }
                                                          });
                                                        } else if (login > 0 && searchProducts[index]
                                                            .favouriteID !=
                                                            null){
                                                          deleteFavAPI(account[0].accountID.toString(), searchProducts[index].productID.toString()).then((value) {
                                                            if(value.success == 1){
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                  searchProducts[index].productName.toString() + " is deleted from favourite list.");
                                                              navigateToProductListPage(context);
                                                            }
                                                          });
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Please login.");
                                                        }
                                                        print('fav');
                                                        for (int i = 0;
                                                            i < product.length;
                                                            i++) {
                                                          if (product[i]
                                                                  .productName ==
                                                              searchProduct[
                                                                      index]
                                                                  .productName) {
                                                            product[i].fav =
                                                                searchProduct[
                                                                        index]
                                                                    .fav;
                                                          }
                                                        }
                                                        // storage.write(key: "product", value: product);
                                                        // storage.read(key: product);
                                                        setState(() {});
                                                      },
                                                    )
                                                  : Text(""),
                                            ),
                                            Expanded(
                                                flex: 70, child: SizedBox()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 40,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(child: Text("")),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                searchProducts[index]
                                                    .productName.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                                            searchProducts[index].retailPrice !=
                                                    searchProducts[index]
                                                        .sellPrice
                                                ? Text(
                                                    'HK\$' +
                                                        searchProducts[index]
                                                            .retailPrice
                                                            .toString(),
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          196, 196, 196, 73),
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                : Text(""),
                                          ],
                                        ),
                                        Expanded(child: Text("")),
                                        Row(
                                          children: <Widget>[
                                            searchProducts[index].retailPrice !=
                                                    searchProducts[index]
                                                        .sellPrice
                                                ? Text(
                                                    'Save \$' +
                                                        (searchProducts[index].retailPrice! - searchProducts[index].sellPrice!)
                                                            .toStringAsFixed(
                                                                1) +
                                                        '!',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          214, 39, 218, 100),
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
              ),
        drawer: NavigationBarPageState().navBar(context),
      ),
      // body:
      // ElevatedButton(onPressed: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      // }, child: Text("haha"),),
    );
  }
}
