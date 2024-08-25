import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatefulWidget {
  SharedPreferences prefs;
  Screen1({super.key, required this.prefs});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  double height = 200;
  int n = 1;
  List<Color> colors = [Colors.red, Colors.blue, Colors.amber, Colors.green];
  Color color = Colors.red;
  Alignment alignment = Alignment.topLeft;
  bool isAnimating = false;

  void _startAnimation() async {
    if (isAnimating) return; // Prevent multiple animations from starting
    isAnimating = true;

    while (isAnimating) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        switch (alignment) {
          case Alignment.topLeft:
            alignment = Alignment.topRight;
            break;
          case Alignment.topRight:
            alignment = Alignment.bottomRight;
            break;
          case Alignment.bottomRight:
            alignment = Alignment.bottomLeft;
            break;
          case Alignment.bottomLeft:
            alignment = Alignment.topLeft;
            break;
        }
      });
    }
  }

  @override
  void dispose() {
    isAnimating = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: double.infinity,
        height: double.infinity,
        color: color,
        child: AnimatedAlign(
          alignment: alignment,
          duration: Duration(seconds: 1),
          child: Icon(
            Icons.square,
            size: 30,
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _startAnimation,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
