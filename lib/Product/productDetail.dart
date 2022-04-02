import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:member/Product/productList.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

Status productDetailsStatus = Status.loading;
Future<ProductDetails> productDetailsAPI(String id, String productID) async {
  productDetailsStatus = Status.loading;
  final response =
  await http.post(Uri.parse('http://api.chunon.me/getProductApp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"accountID": id, "productID": productID}));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    productDetailsStatus = Status.success;
    // List b = jsonDecode(response.body);
    // print(b);
    return ProductDetails.fromJson(jsonDecode(response.body));
  } else {
    productDetailsStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class ProductDetails {
  List<BranchProduct>? branchProduct;
  double? cost;
  int? favouriteID;
  String? productDescription;
  String? productID;
  String? productImage;
  String? productName;
  int? productStatus;
  double? retailPrice;
  double? sellPrice;

  ProductDetails(
      {this.branchProduct,
        this.cost,
        this.favouriteID,
        this.productDescription,
        this.productID,
        this.productImage,
        this.productName,
        this.productStatus,
        this.retailPrice,
        this.sellPrice});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    if (json['branchProduct'] != null) {
      branchProduct = <BranchProduct>[];
      json['branchProduct'].forEach((v) {
        branchProduct!.add(new BranchProduct.fromJson(v));
      });
    }
    cost = json['cost'];
    favouriteID = json['favouriteID'];
    productDescription = json['productDescription'];
    productID = json['productID'];
    productImage = json['productImage'];
    productName = json['productName'];
    productStatus = json['productStatus'];
    retailPrice = json['retailPrice'];
    sellPrice = json['sellPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branchProduct != null) {
      data['branchProduct'] =
          this.branchProduct!.map((v) => v.toJson()).toList();
    }
    data['cost'] = this.cost;
    data['favouriteID'] = this.favouriteID;
    data['productDescription'] = this.productDescription;
    data['productID'] = this.productID;
    data['productImage'] = this.productImage;
    data['productName'] = this.productName;
    data['productStatus'] = this.productStatus;
    data['retailPrice'] = this.retailPrice;
    data['sellPrice'] = this.sellPrice;
    return data;
  }
}

class BranchProduct {
  String? branchName;
  int? qty;

  BranchProduct({this.branchName, this.qty});

  BranchProduct.fromJson(Map<String, dynamic> json) {
    branchName = json['branchName'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchName'] = this.branchName;
    data['qty'] = this.qty;
    return data;
  }
}

class ProductDetailPage extends StatefulWidget {
  String productID;
  ProductDetailPage({Key? key, required this.productID}) : super(key: key);

  @override
  ProductDetailPagePageState createState() => ProductDetailPagePageState();
}

class ProductDetailPagePageState extends State<ProductDetailPage> {
  late ProductDetails productDetails;
  late List<BranchProduct> branchProduct;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productDetailsAPI(account[0].accountID.toString(), widget.productID).then((value) {
      productDetails = value;
      branchProduct = productDetails.branchProduct!;
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ProductListPage()),
            (Route<dynamic> route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Product Detail"), //widget.productDetail.productName
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
        drawer: NavigationBarPageState().navBar(context),
        body: productDetailsStatus == Status.loading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurpleAccent,
          ),
        )
            : SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text("")),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.97,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(
                                  apiDomain + productDetails.productImage.toString()),
                              fit: BoxFit.contain)),
                    ),
                    Expanded(child: Text("")),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    productDetails.productName.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromRGBO(0, 0, 0, 60),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'HK\$' +
                                        productDetails.sellPrice
                                            .toString() +
                                        ' ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                productDetails.retailPrice !=
                                    productDetails.sellPrice
                                    ? Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          'HK\$' +
                                              productDetails.retailPrice
                                                  .toString(),
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                196, 196, 196, 73),
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                productDetails.retailPrice !=
                                    productDetails.sellPrice
                                    ? Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          'Save \$' +
                                              (productDetails
                                                          .retailPrice! -
                                                  productDetails
                                                          .sellPrice!)
                                                  .toStringAsFixed(1) +
                                              '!',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                214, 39, 218, 100),
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Column(
                          children: <Widget>[
                            login > 0
                                ? GestureDetector(
                                    child: productDetails.favouriteID != null &&
                                            login > 0
                                        ? Icon(Icons.favorite,
                                            color: Colors.redAccent)
                                        : Icon(Icons.favorite_border),
                                    onTap: () {
                                      if (login > 0 && productDetails.favouriteID ==
                                          null) {
                                        print(account[0].accountID.toString() + widget.productID);
                                        addFavAPI(account[0].accountID.toString(), widget.productID).then((value) {
                                          if(value.success == 1 && favStatus == Status.success){
                                            Fluttertoast.showToast(
                                                msg:
                                                productDetails.productName.toString() + " is added to favourite list.");
                                            navigateToProductDetailPage(context, productDetails.productID.toString());
                                          }
                                        });
                                      } else if (login > 0 && productDetails
                                          .favouriteID !=
                                          null){
                                        deleteFavAPI(account[0].accountID.toString(), widget.productID).then((value) {
                                          if(value.success == 1 && favStatus == Status.success){
                                            Fluttertoast.showToast(
                                                msg:
                                                productDetails.productName.toString() + " is deleted from favourite list.");
                                            navigateToProductDetailPage(context, productDetails.productID.toString());
                                          }
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                            "Please login.");
                                      }
                                      // storage.write(key: "product", value: product);
                                      // storage.read(key: product);
                                      setState(() {});
                                    },
                                  )
                                : Text(""),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(top: 0),
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Branch Quantity",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text('Branch'),
                            ),
                            DataColumn(
                              label: Text('Quantity'),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            branchProduct.length,
                            (int index) => DataRow(
                              color: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.08);
                                }
                                if (index.isEven) {
                                  return Colors.grey.withOpacity(0.3);
                                }
                                return null; // Use default value for other states and odd rows.
                              }),
                              cells: <DataCell>[
                                DataCell(Text(branchProduct[index].branchName.toString())),
                                DataCell(
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(branchProduct[index].qty.toString()),
                                  ),
                                ),
                                // DataCell(Text(branch[index].qty.toString())),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
