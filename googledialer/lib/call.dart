import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  final String phoneNumber;
  final String callerName; // Added caller name parameter
  final String numberHolderName; // Added number holder name parameter

  CallPage({
    required this.phoneNumber,
    required this.callerName,
    required this.numberHolderName,
  }); // Updated constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call $callerName'),
        backgroundColor: Color.fromARGB(255, 237, 231, 231),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'padam/caller.jpg', // Path to your background image
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of the background image
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevents the column from expanding beyond its content
              mainAxisAlignment: MainAxisAlignment.center, // Centers the column content vertically
              children: [
                // Container for the account icon, caller name, and number holder
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Prevents the inner column from expanding
                    children: [
                      Icon(Icons.account_circle, size: 60), // Account icon
                      SizedBox(height: 16), // Vertical spacing
                      Text(
                        callerName, // Display the caller's name
                        style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold), // Adjust style as needed
                      ),
                      SizedBox(height: 8), // Vertical spacing
                      Text(
                        "Dialing...",
                        style: TextStyle(fontSize: 14, color: Colors.white), // Adjust color for visibility
                      ),
                      SizedBox(height: 8), // Vertical spacing
                      Text(
                        '$phoneNumber', // Display the name of the number holder
                        style: TextStyle(fontSize: 18, color: Colors.white70), // Adjust color for visibility
                      ),
                    ],
                  ),
                ),
                 
                // Container for caller options
                SizedBox(height: 70),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // First row of icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconButton(Icons.mic_off, 'Mute', () {
                            // Handle mute functionality
                          }),
                          _buildIconButton(Icons.dialpad, 'Keypad', () {
                            // Handle keypad functionality
                          }),
                          _buildIconButton(Icons.video_call, 'Video', () {
                            // Handle video functionality
                          }),
                          _buildIconButton(Icons.volume_up, 'Speaker', () {
                            // Handle speaker functionality
                          }),
                        ],
                      ),
                      SizedBox(height: 16), // Vertical spacing between rows
                      // Second row of icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconButton(Icons.add_call, 'Add Call', () {
                            // Handle add call functionality
                          }),
                          _buildIconButton(Icons.bluetooth, 'Bluetooth', () {
                            // Handle bluetooth functionality
                          }),
                          _buildIconButton(Icons.pause, 'Hold', () {
                            // Handle hold functionality
                          }),
                          _buildIconButton(Icons.account_circle_outlined, 'Contacts', () {
                            // Handle contacts functionality
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle end call functionality
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Red color for end call button
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 30,
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

  Widget _buildIconButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white), // Adjust icon color for visibility
          onPressed: onPressed,
          iconSize: 30,
        ),
        Text(label, style: TextStyle(color: Colors.white)), // Adjust text color for visibility
      ],
    );
  }
}