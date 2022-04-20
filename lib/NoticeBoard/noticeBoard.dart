import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:member/Var/natigate.dart';

import '../main.dart';
import '../Navigation/navigationBar.dart';
import '../Var/var.dart';

Status noticeBoardsStatus = Status.loading;
Future<List<NoticeBoards>> noticeBoardsAPI() async {
  noticeBoardsStatus = Status.loading;
  final response = await http.post(
    Uri.parse('http://api.chunon.me/getNoticeBoards_M'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    noticeBoardsStatus = Status.success;
    List<NoticeBoards> myModels = (jsonDecode(response.body) as List)
        .map((i) => NoticeBoards.fromJson(i))
        .toList();
    return myModels;
  } else {
    noticeBoardsStatus = Status.error;
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get NoticeBoard');
  }
}

class NoticeBoards {
  String? noticeBoardID;
  String? staffID;
  String? noticeTitle;
  String? releaseDateTime;
  String? noticeBoardDescription;
  int? isActive;
  String? createDateTime;

  NoticeBoards(
      {this.noticeBoardID,
      this.staffID,
      this.noticeTitle,
      this.releaseDateTime,
      this.noticeBoardDescription,
      this.isActive,
      this.createDateTime});

  NoticeBoards.fromJson(Map<String, dynamic> json) {
    noticeBoardID = json['noticeBoardID'];
    staffID = json['staffID'];
    noticeTitle = json['noticeTitle'];
    releaseDateTime = json['releaseDateTime'];
    noticeBoardDescription = json['noticeBoardDescription'];
    isActive = json['isActive'];
    createDateTime = json['createDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noticeBoardID'] = this.noticeBoardID;
    data['staffID'] = this.staffID;
    data['noticeTitle'] = this.noticeTitle;
    data['releaseDateTime'] = this.releaseDateTime;
    data['noticeBoardDescription'] = this.noticeBoardDescription;
    data['isActive'] = this.isActive;
    data['createDateTime'] = this.createDateTime;
    return data;
  }
}

class NoticeBoardPage extends StatefulWidget {
  @override
  NoticeBoardPageState createState() => NoticeBoardPageState();
}

class NoticeBoardPageState extends State<NoticeBoardPage> {
  List<NoticeBoards> notices = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (login > 0) {
      updateAccountAPI(account[0].accountID.toString()).then((value) {
        account = [];
        account.add(value);
        setState(() {});
      });
    }
    noticeBoardsAPI().then((value) {
      notices = value;
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
          title: Text("Notice"),
          centerTitle: true,
        ),
        drawer: NavigationBarPageState().navBar(context),
        body: status == Status.loading || noticeBoardsStatus == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              )
            : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemCount: notices.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.07,
                                top: 10,
                                bottom: 10,
                                right: 10,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      notices[index].noticeTitle.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      notices[index]
                                          .noticeBoardDescription
                                          .toString(),
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(child: Container()),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          notices[index]
                                              .releaseDateTime!
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
