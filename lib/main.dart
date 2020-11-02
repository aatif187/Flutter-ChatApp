import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/helperfunction.dart';
import 'package:chat_app/views/chatroom_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isloggedIn;
  @override
  void initState() {
    getloggedIninfo();
    super.initState();
  }

  getloggedIninfo() async {
    await HelperFunction.getUserLoggedInsharedpreferneces().then((value) {
      setState(() {
        isloggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat App',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff1F1F1F),
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: isloggedIn != null
            ? isloggedIn ? ChatRoom() : Authenticate()
            : Container(
                child: Authenticate(),
              ));
  }
}
