import 'package:flutter/material.dart';
import 'package:gallery/gallary.dart';
import 'package:gallery/view.dart';




void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => Gallery(),
      "/screen2":(context)=>Imageview(imagePath: '',),
    },
  ));
}