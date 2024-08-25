import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatefulWidget {
  SharedPreferences prefs;
  Screen1({super.key,required this.prefs});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  double height = 200;
  int n = 1;
  List<Alignment> almt = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomRight,
    Alignment.topLeft
  ];
  Color color = Colors.red;
  Alignment alignment = Alignment.topLeft;
  void move(){
    setState(() {
      alignment= almt[n];
  });
  n=(n+1)%4;
  Future.delayed(Duration(seconds: 1),move);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),

    ),
    body: Center(
      child:Container(
        height: 200,
        width: 200,
        color: Colors.blue,
        child: AnimatedPadding(
          padding: EdgeInsets.all(n.toDouble()*20),
          duration: Duration(seconds: 1),
          child: AnimatedOpacity(
            opacity: n/3,
            duration: Duration(seconds: 1),
            child: Container(
              height:50,
            width: 50,
            color: Colors.green,
            child: AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: n.toDouble()*15,
              ),
              duration: Duration(seconds: 1),
              child: Text("A"),
            ),
      ),
      ),
    ),
    ),
    ),
    floatingActionButton: ElevatedButton(
      onPressed: move,
      child: Icon(Icons.abc),
    )
    );
  }
}

