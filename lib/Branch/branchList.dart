import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Var/natigate.dart';
import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

class BranchListPage extends StatefulWidget {
  @override
  BranchListPageState createState() => BranchListPageState();
}

class BranchListPageState extends State<BranchListPage> {
  String dropdownValue = 'All District';
  List<String> dropdown = [
    "All District",
    "New Territories",
    "Kowloon",
    "Hong Kong Island"
  ];
  late List<Branch> branch;
  late List<Branch> filterBranch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateAccountAPI(account[0].accountID.toString()).then((value) {
      account = [];
      account.add(value);
      setState(() {});
    });
    branchAPI().then((value) {
      branch = [];
      branch = value;
      filterBranch = branch;
      setState(() {});
    });
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
          title: Text("Branch"),
          centerTitle: true,
        ),
        drawer: NavigationBarPageState().navBar(context),
        body: status == Status.loading || branchstatus == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(""),
                      ),
                      Expanded(
                        flex: 6,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            dropdownValue = newValue!;
                            if (dropdownValue == "All District") {
                              filterBranch = branch;
                            } else if (dropdownValue == "New Territories") {
                              filterBranch = [];
                              for (int i = 0; i < branch.length; i++) {
                                if (branch[i].district == "NT") {
                                  filterBranch.add(branch[i]);
                                  print(branch[i].district);
                                }
                              }
                            } else if (dropdownValue == "Kowloon") {
                              filterBranch = [];
                              for (int i = 0; i < branch.length; i++) {
                                if (branch[i].district == "KLN") {
                                  filterBranch.add(branch[i]);
                                  print(branch[i].district);
                                }
                              }
                            } else if (dropdownValue == "Hong Kong Island") {
                              filterBranch = [];
                              for (int i = 0; i < branch.length; i++) {
                                if (branch[i].district == "HK") {
                                  filterBranch.add(branch[i]);
                                  print(branch[i].district);
                                }
                              }
                            }
                            setState(() {});
                          },
                          items: dropdown
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(""),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Container(
                  //       padding: EdgeInsets.only(left: 20),
                  //       child: Text(
                  //         dropdownValue,
                  //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Expanded(
                    child: ListView.builder(
                      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemCount: filterBranch.length,
                      itemBuilder: (BuildContext ctx, index) {
                        String district = "";
                        switch (filterBranch[index].district) {
                          case "NT":
                            {
                              district = "New Territories";
                            }
                            break;
                          case "HK":
                            {
                              district = "Hong Kong Island";
                            }
                            break;
                          case "KLN":
                            {
                              district = "Kowloon";
                            }
                        }
                        return GestureDetector(
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.07,
                                  top: 20,
                                  bottom: 10,
                                  right: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "District: ",
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.deepPurple),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                district,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Name: ",
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.deepPurple),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                filterBranch[index]
                                                    .branchName
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Address:",
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.deepPurple),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                filterBranch[index]
                                                    .address
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            "https://media.istockphoto.com/vectors/convenience-store-vector-id1009031800?k=20&m=1009031800&s=170667a&w=0&h=r6UE66Xv6zgkHuyWbOzy_nrRnfNBwSS1nV7gfqNPGZY=")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            // navigateToBranchDetailPage(context, filterBranch[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
