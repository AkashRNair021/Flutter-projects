import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contacts.dart'; // Import your ContactsPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization
  final SharedPreferences prefs = await SharedPreferences.getInstance(); // Get shared preferences instance

  runApp(MyApp(prefs: prefs)); // Pass the shared preferences instance to MyApp
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContactsPage(prefs: prefs), // Set ContactsPage as the home page
    );
  }
}