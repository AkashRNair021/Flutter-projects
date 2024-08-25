import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatefulWidget {
  SharedPreferences prefs;
  Screen1({super.key, required this.prefs});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with SingleTickerProviderStateMixin {
  bool x = true;
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(
        child: IconButton(
          onPressed: () {
            if (x) {
              controller.forward();
            } else {
              controller.reverse();
            }
            x = !x;
          },
          icon: AnimatedIcon(
            progress: animation,
            icon: AnimatedIcons.pause_play,
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (x) {
            controller.forward();
          } else {
            controller.reverse();
          }
          x = !x;
        },
        child: Icon(Icons.abc),
      ),
    );
  }
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
