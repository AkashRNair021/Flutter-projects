import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatefulWidget {
  MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Color rightButtonColor = Colors.blue;
  Color leftButtonColor = Colors.green;
  final List<Color> colors = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.orange];
  int colorIndex = 0;

  void changeRightButtonColor() {
    setState(() {
      colorIndex = (colorIndex + 1) % colors.length;
      rightButtonColor = colors[colorIndex];
    });
  }

  void changeLeftButtonColor() {
    setState(() {
      colorIndex = (colorIndex - 1 + colors.length) % colors.length;
      leftButtonColor = colors[colorIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Change Buttons'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap the left button to change color in reverse.\nTap the right button to change color.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Text("Color order >>> Blue , Red ,Green ,Yellow , Orange"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Left button pressed');
                    changeLeftButtonColor();
                  },
                  onPanUpdate: (details) {
                    print('Left button: $details');
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    color: leftButtonColor,
                    margin: EdgeInsets.all(8.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Right button pressed');
                    changeRightButtonColor();
                  },
                  onPanUpdate: (details) {
                    print('Right button: $details');
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    color: rightButtonColor,
                    margin: EdgeInsets.all(8.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
