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
  List searchProduct = product;
  @override
  void initState() {
    // TODO: implement initState
    searchProduct = product;
    super.initState();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "press one more time to close the app");
      return Future.value(false);
    }
    return Future.value(true);
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
                login > 0
                    ? navigateToFavouriteProductPage(context)
                    : navigateToLoginPage(context);
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: TextField(
                // obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Search Product',
                ),
                onChanged: (text) {
                  searchProduct = [];
                  print(searchProduct);
                  print(product);
                  if (text != "") {
                    for (int i = 0; i < product.length; i++) {
                      if (product[i]
                          .productName
                          .toLowerCase()
                          .contains(text.toLowerCase())) {
                        searchProduct.add(product[i]);
                      }
                    }
                  } else {
                    searchProduct = product;
                  }
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemCount: searchProduct.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () async {
                      print(searchProduct[index]);
                      navigateToProductDetailPage(
                          context, searchProduct[index]);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: (MediaQuery.of(context).size.width - 50) / 2,
                            padding: EdgeInsets.only(top: 10),
                            height: 150,
                            child: Row(
                              children: <Widget>[
                                Expanded(flex: 20, child: SizedBox()),
                                Expanded(
                                  flex: 80,
                                  child: Image(
                                    image: NetworkImage(
                                        searchProduct[index].productImage),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 30,
                                        child: GestureDetector(
                                          child: searchProduct[index].fav % 2 ==
                                                      0 &&
                                                  login > 0
                                              ? Icon(Icons.favorite,
                                                  color: Colors.redAccent)
                                              : Icon(Icons.favorite_border),
                                          onTap: () {
                                            if (login > 0) {
                                              searchProduct[index].fav++;
                                            }
                                            print('fav');
                                            for (int i = 0;
                                                i < product.length;
                                                i++) {
                                              if (product[i].productName ==
                                                  searchProduct[index]
                                                      .productName) {
                                                product[i].fav =
                                                    searchProduct[index].fav;
                                              }
                                            }
                                            // storage.write(key: "product", value: product);
                                            // storage.read(key: product);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      Expanded(flex: 70, child: SizedBox()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 60) / 2,
                            height: 100,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(searchProduct[index].productName),
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
                            offset: Offset(0, 5), // changes position of shadow
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
