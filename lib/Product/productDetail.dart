import 'package:flutter/material.dart';

import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class ProductDetailPage extends StatefulWidget {
  Product productDetail;
  ProductDetailPage({Key? key, required this.productDetail}) : super(key: key);

  @override
  ProductDetailPagePageState createState() => ProductDetailPagePageState();
}

class ProductDetailPagePageState extends State<ProductDetailPage> {
  List<Product> suggestProduct = [];
  @override
  void initState() {
    for (int i = 0; i < product.length; i++) {
      if (widget.productDetail.productID != product[i].productID) {
        suggestProduct.add(product[i]);
      }
    }
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Product Detail"), //widget.productDetail.productName
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      drawer: NavigationBarPageState().navBar(context),
      body: SingleChildScrollView(
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
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        image: DecorationImage(
                            image:
                                NetworkImage(widget.productDetail.productImage),
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
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  widget.productDetail.productName,
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
                                      widget.productDetail.sellPrice
                                          .toString() +
                                      ' ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'HK\$' +
                                      widget.productDetail.retailPrice
                                          .toString(),
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(196, 196, 196, 73),
                                    fontSize: 15,
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
                                  'Save \$' +
                                      (widget.productDetail.retailPrice -
                                              widget.productDetail.sellPrice)
                                          .toStringAsFixed(1) +
                                      '!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(214, 39, 218, 100),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.05,
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
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
                      // child: DataTable(
                      //   columns: <DataColumn>[
                      //     DataColumn(
                      //       label: Text(
                      //         'Name',
                      //         style: TextStyle(fontStyle: FontStyle.italic),
                      //       ),
                      //     ),
                      //     DataColumn(
                      //       label: Text(
                      //         'Role',
                      //         style: TextStyle(fontStyle: FontStyle.italic),
                      //       ),
                      //     ),
                      //   ],
                      //   rows: const <DataRow>[
                      //     DataRow(
                      //       cells: <DataCell>[
                      //         DataCell(Text('Sarah')),
                      //         DataCell(Text('19')),
                      //       ],
                      //     ),
                      //     DataRow(
                      //       cells: <DataCell>[
                      //         DataCell(Text('Janine')),
                      //         DataCell(Text('43')),
                      //       ],
                      //     ),
                      //     DataRow(
                      //       cells: <DataCell>[
                      //         DataCell(Text('William')),
                      //         DataCell(Text('27')),
                      //       ],
                      //     ),
                      //   ],
                      // ),
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
                          6,
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
                              DataCell(Text('Row $index')),
                              DataCell(Text('Row $index')),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
