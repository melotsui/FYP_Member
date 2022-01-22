import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  List searchProduct = product;
  var imageArray = [
    'https://images.hktv-img.com/images/HKTV/15953/400285_main_73896179_20210920110521_01_1200.jpg',
    'https://images.hktvmall.com/h0888001/427e4800fe055ca10b737d54e45ca60f787d3de5/h0888001_10060249_190315122522_01_515.jpg',
    'https://hk.ulifestyle.com.hk/cms/images/event/w600/202111/20211129180351_1_2.png',
    'http://images.hktvmall.com/h0888001/967376c97fb5b9399d8d64f87e9ee0122240ab80/h0888001_10137528_191121053206_01_1200.jpg',
    'http://images.hktvmall.com/h1115001/260619/h1115001_10138104_200828031816_01_1200.jpg'
  ];

  var itemName = [
    'Coca-Cola - Coca-Cola Zero (330ml X 8)',
    'Laurier - Anti-Bacterial Ultra Slim Night 30cm',
    'COOL Water 750ml',
    'LINDOR Milk Cornet',
    'Trappist Dairy - Fresh Milk (Chilled) 236ml'
  ];

  var price = ['\$48', '\$33', '\$6', '\$129', '\$5.5'];
  var fav = varFav;
  @override
  void initState() {
    // TODO: implement initState
    searchProduct = product;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Product List"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_alert_sharp),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
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
                    if (product[i].productName
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
                return Container(
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
                                image: NetworkImage(searchProduct[index].productImage),
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
                                      child: searchProduct[index].fav % 2 == 0 && login > 0
                                          ? Icon(Icons.favorite,
                                              color: Colors.redAccent)
                                          : Icon(Icons.favorite_border),
                                      onTap: () {
                                        searchProduct[index].fav++;
                                        for(int i=0; i<product.length; i++){
                                          if(product[i].productName == searchProduct[index].productName){
                                            product[i].fav = searchProduct[index].fav;
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
                );
              },
            ),
          ),
        ],
      ),
      drawer: NavigationBarPageState().navBar(context),
      // body:
      // ElevatedButton(onPressed: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      // }, child: Text("haha"),),
    );
  }
}
