import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

Widget MyApp() {
  return MaterialApp(
    home: MyHomePage(),
  );
}

Widget MyHomePage() {
  return Scaffold(
    body: Column(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/bw.jpeg'), // Make sure to add the image to your assets
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  color: Colors.teal,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'SUSEN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'SMITH',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Marketing Manager',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[900],
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
          child: Row(
            children: [
              Icon(Icons.hexagon_outlined,
              color: Colors.white,
              
              
              ),
              
              Text(
                
                'BRAND ART\nBest Company',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily:"Kalam",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
           
              // Text(
              //   //'Best Company',
              //   style: TextStyle(
              //     color: Colors.white70,
              //     fontSize: 14,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    ),
  );
}
