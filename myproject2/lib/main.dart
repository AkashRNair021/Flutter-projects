import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'asset/bw.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(122, 0, 0, 0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Teamio",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Bring your work & team\ntogether",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.753),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(
                      Icons.arrow_circle_right,
                      color: Color.fromARGB(255, 61, 55, 249),
                      size: 48,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}