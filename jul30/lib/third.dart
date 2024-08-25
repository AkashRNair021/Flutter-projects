import 'package:flutter/material.dart';

class Third extends StatefulWidget {
  third({super.key});
  @override
  State<Third> createState() {
    return _ThirdState();
  }
}

class _ThirdState extends State<Third> {
  int count = 0;

  @override
  Widget build(Buildcontext context) {
    return Container(
      child: Column(
        mainAxisAlingment: MainAxisAlignment.center,
        children: [
          Text(count.toString()),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
              print(count);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
