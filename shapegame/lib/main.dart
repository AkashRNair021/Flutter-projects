import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Shape Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShapeGeneratorPage(),
    );
  }
}

class ShapeGeneratorPage extends StatefulWidget {
  @override
  _ShapeGeneratorPageState createState() => _ShapeGeneratorPageState();
}

class _ShapeGeneratorPageState extends State<ShapeGeneratorPage> {
  double shapeSize = 0.0; // Initial size is set to 0 (invisible)
  bool isSquare = true; // Flag to determine whether to show square or circle

  void _generateSquare() {
    setState(() {
      shapeSize = 100.0; // Set an initial size for the square
      isSquare = true; // Set the flag to square
    });
  }

  void _generateCircle() {
    setState(() {
      shapeSize = 100.0; // Set an initial size for the circle
      isSquare = false; // Set the flag to circle
    });
  }

  void _increaseShapeSize() {
    setState(() {
      shapeSize += 20.0; // Increase the size of the shape
    });
  }

  void _decreaseShapeSize() {
    setState(() {
      if (shapeSize > 20.0) {
        shapeSize -= 20.0; // Decrease the size of the shape
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Shape Generator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: shapeSize > 0
                ? AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: shapeSize,
                    height: shapeSize,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                    ),
                  )
                : SizedBox.shrink(), // If shapeSize is 0, show nothing
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAnimatedButton(
                icon: Icons.crop_square,
                onPressed: _generateSquare,
              ),
              _buildAnimatedButton(
                icon: Icons.circle,
                onPressed: _generateCircle,
              ),
              _buildAnimatedButton(
                icon: Icons.add,
                onPressed: _increaseShapeSize,
              ),
              _buildAnimatedButton(
                icon: Icons.remove,
                onPressed: _decreaseShapeSize,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.withOpacity(0.7),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
