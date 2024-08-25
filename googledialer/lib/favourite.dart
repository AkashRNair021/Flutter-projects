import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  final List<Map<String, String>> favourites;

  FavouritesPage({super.key, required this.favourites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: favourites.isEmpty
          ? Center(
              child: Text('No favourites yet'),
            )
          : ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favourites[index]['name']!),
                  subtitle: Text(favourites[index]['phone']!),
                );
              },
            ),
    );
  }
}