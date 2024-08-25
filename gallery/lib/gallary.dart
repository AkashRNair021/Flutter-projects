import 'package:flutter/material.dart';
import 'package:gallery/view.dart';

class Gallery extends StatelessWidget {
  Gallery({super.key});

  final List<String> imagePaths = [
    'assets/img1.jpeg',
    'assets/img2.jpeg',
    'assets/img3.jpeg',
    'assets/img4.jpeg',
    'assets/img5.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          final imagePath = imagePaths[index];
          return GestureDetector(
            onTap: () {
              _onImageTap(context, imagePath);
            },
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  void _onImageTap(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Imageview(imagePath: imagePath),
      ),
    );
  }
}
