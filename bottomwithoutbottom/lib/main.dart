import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Bottom Sheet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MessageDisplayPage(),
    );
  }
}

class MessageDisplayPage extends StatefulWidget {
  @override
  _MessageDisplayPageState createState() => _MessageDisplayPageState();
}

class _MessageDisplayPageState extends State<MessageDisplayPage> with SingleTickerProviderStateMixin {
  String message = ''; // Variable to hold the message
  bool isMessageVisible = false; // Control message visibility
  late AnimationController _controller; // Animation controller
  late Animation<double> _animation; // Animation for height

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _showMessage() {
    setState(() {
      message = '!'; // Set the message when the button is pressed
      isMessageVisible = true; // Show the message
    });
    _controller.forward(); // Animate the appearance of the message

    // Clear the message after a delay
    Future.delayed(Duration(seconds: 2), () {
      _controller.reverse(); // Animate the disappearance of the message
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          message = ''; // Clear the message
          isMessageVisible = false; // Hide the message
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Bottom Sheet'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showMessage,
          child: Text('Press Me'),
        ),
      ),
      bottomSheet: isMessageVisible
          ? SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 1), // Start off-screen (bottom)
                end: Offset(0, 0), // End at the bottom of the screen
              ).animate(_controller),
              child: Container(
                padding: EdgeInsets.all(16.0),
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : null,
    );
  }
}
