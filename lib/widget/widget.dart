import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Default_appbar() {
  return AppBar(
    title: Text(
      "ChatApp",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    elevation: 5.0,
  );
}

InputDecoration Customised_InputDecoration(hintText) {
  return InputDecoration(
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54, fontSize: 16));
}
