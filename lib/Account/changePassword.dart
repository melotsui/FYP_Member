
// body: ListView.builder(
//
// itemCount: 5,
// itemBuilder: (context, idx){
// print("$idx");
// return Card(
// child: Row(
// textDirection: TextDirection.ltr,
// children: <Widget>[
// Container(
// height: 200,
// width: MediaQuery.of(context).size.width * 0.33,
// // fit: BoxFit.contain, // otherwise the logo will be tiny
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(
// imageArray[idx]),
// fit: BoxFit.contain),
//
// ),
// // Image.network("https://hk.ulifestyle.com.hk/cms/images/event/w600/202111/20211129180351_1_2.png"),
// ),
// Expanded(
// child: Text(itemName[idx], textAlign: TextAlign.center),
// ),
// Expanded(
// // child: Text(price[idx], textAlign: TextAlign.center),
// child: Column(
// children: [
// GestureDetector(
// child: fav[idx] % 2 == 0 && login > 0 ? Icon(Icons.favorite, color: Colors.redAccent) : Icon(Icons.favorite_border),
// onTap: () {
// fav[idx] = fav[idx] + 1;
// setState(() {
//
// });
//
// },
// ),
// SizedBox(height: 10,),
// Text(price[idx], textAlign: TextAlign.center),
// ],
// ),
// ),
// ],
// ),
// );
// },
// ),