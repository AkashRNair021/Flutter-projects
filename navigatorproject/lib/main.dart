import 'package:flutter/material.dart';
import 'package:navigatorproject/screen1.dart';
import 'package:navigatorproject/screen2.dart';
import 'package:navigatorproject/screen3.dart';

void main() {
  runApp(MaterialApp(
          initialRoute: "/",
          routes: {
              "/": (context) => LoginScreen(),
              "/screen"
              "/screen1":(context) => RegisterScreen(),
              "/screen3":(context) => ForgotPasswordScreen(),
          },
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A237E), // Set background color to dark blue
      body: Stack(
        children: [
          // Background circles
          Positioned(
            top: -50,
            right: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Color(0xFFFFEB3B), // Yellow circle
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Color(0xFFF48FB1), // Pink circle
            ),
          ),
          Positioned(
            bottom: 100,
            right: -50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFFF7043), // Orange circle
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Color(0xFF1A237E), // Dark blue
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'WELCOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                // Login button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF48FB1), // Pink
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Color(0xFF1A237E), // Dark blue
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Register button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF48FB1), // Pink
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      color: Color(0xFF1A237E), // Dark blue
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
