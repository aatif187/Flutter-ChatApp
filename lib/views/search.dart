import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'communication_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchtexteditingcontroller =
      new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot seachSnapshot;
  initiateSearch() async {
    await databaseMethods
        .getuserbyUserName(searchtexteditingcontroller.text)
        .then((val) {
      setState(() {
        seachSnapshot = val;
      });
    });
  }

  Widget SearchList() {
    return seachSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: seachSnapshot.documents.length,
            itemBuilder: (context, index) {
              return searchTile(
                seachSnapshot.documents[index].data["name"],
                seachSnapshot.documents[index].data["email"],
              );
            })
        : Container();
  }

  createChatRoomAndstartConversation(String username) {
    if (username != Constants.MyName) {
      String ChatRoomID = getChatRoomId(username, Constants.MyName);
      List<String> users = [username, Constants.MyName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": ChatRoomID
      };
      databaseMethods.CreateChatRoom(ChatRoomID, chatRoomMap);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(ChatRoomID)));
    }
  }

  Widget searchTile(String userName, String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndstartConversation(userName);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text("Message",
                    style: TextStyle(color: Colors.white, fontSize: 12))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Default_appbar(),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.grey[700],
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: searchtexteditingcontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "username",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        )),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          "assets/images/search_white.png",
                          height: 25,
                          width: 25,
                        )),
                  )
                ],
              ),
            ),
            SearchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
