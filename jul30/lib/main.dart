import 'package:flutter/material.dart';

void main() {
  runApp(MyFirstWidget());
}

class MyFirstWidget extends StatelessWidget {
  MyFirstWidget({super.key});
  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    Widget build(BuildContext context){
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child:Third()
            ),
        ),
      )
    }
  }
}
