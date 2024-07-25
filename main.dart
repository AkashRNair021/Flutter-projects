import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
    home: Scaffold(
      body: SizedBox(
        height: 400,
        child: Image.asset(
              "assets/pookie.jpg",
              fit:BoxFit.contain,
        )
        ),
    ),
  ),
);
}
