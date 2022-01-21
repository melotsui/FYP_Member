import 'package:flutter/material.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class ProductListPage extends StatefulWidget {
  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {
  var imageArray = [
    'https://images.hktv-img.com/images/HKTV/15953/400285_main_73896179_20210920110521_01_1200.jpg',
    'https://images.hktvmall.com/h0888001/427e4800fe055ca10b737d54e45ca60f787d3de5/h0888001_10060249_190315122522_01_515.jpg',
    'https://hk.ulifestyle.com.hk/cms/images/event/w600/202111/20211129180351_1_2.png',
    'http://images.hktvmall.com/h0888001/967376c97fb5b9399d8d64f87e9ee0122240ab80/h0888001_10137528_191121053206_01_1200.jpg',
    'http://images.hktvmall.com/h1115001/260619/h1115001_10138104_200828031816_01_1200.jpg'
  ];

  var itemName = [
    'Coca-Cola - Coca-Cola Zero \n(330ml X 8)',
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
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Product List"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),

        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(

        itemCount: 5,
        itemBuilder: (context, idx){
          print("$idx");
          return Card(
            child: Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.33,
                  // fit: BoxFit.contain, // otherwise the logo will be tiny
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            imageArray[idx]),
                        fit: BoxFit.contain),

                  ),
                  // Image.network("https://hk.ulifestyle.com.hk/cms/images/event/w600/202111/20211129180351_1_2.png"),
                ),
                Expanded(
                  child: Text(itemName[idx], textAlign: TextAlign.center),
                ),
                Expanded(
                  // child: Text(price[idx], textAlign: TextAlign.center),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: fav[idx] % 2 ==1 ? Icon(Icons.favorite_border) : Icon(Icons.favorite, color: Colors.redAccent),
                        onTap: () {
                          fav[idx] = fav[idx] + 1;
                          setState(() {

                          });

                        },
                      ),
                      SizedBox(height: 10,),
                      Text(price[idx], textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // body:
      // ElevatedButton(onPressed: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      // }, child: Text("haha"),),
    );
  }
}