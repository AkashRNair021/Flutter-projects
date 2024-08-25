import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  MyWidget({super.key});
  final List list = [
    "Item",
    "Item",
    "Item",
    "Item",
    "Item",
    "Item",
    "Item",
    "Item",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GestureDetector(
      onTap: () {
        print("object");
      },
      child: Container(
        height: 200,
        width: 200,
        color: Colors.cyanAccent,
      ),
    )
    bottomNavigationBar:NavigationBar(
      backgroundColor: Colors.deepOrange,
      elevation: 2,
      height: 80,  
      destinations: [
        IconButton(onPressed: (){}, icon: Icon(Icons.home)),
      ],)
    );
  }
}
