import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'name': 'Devan', 'profilePic': 'assets/img1.jpeg', 'details': 'STUDENT'},
    {'name': 'Akash', 'profilePic': 'assets/img2.jpeg', 'details': 'STUDENT'},
    {'name': 'Adithya', 'profilePic': 'assets/img3.jpeg', 'details': 'STUDENT'},
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLUTTER COMPANY'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      name: contacts[index]['name']!,
                      profilePic: contacts[index]['profilePic']!,
                      details: contacts[index]['details']!,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: contacts[index]['profilePic']!,
                child: CircleAvatar(
                  backgroundImage: AssetImage(contacts[index]['profilePic']!),
                ),
              ),
            ),
            title: Text(contacts[index]['name']!),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String name;
  final String profilePic;
  final String details;

  ProfilePage({required this.name, required this.profilePic, required this.details});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var turns;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: AnimatedRotation(
          turns: turns,
          duration: Duration(seconds: 30),
          child: Container(height:200,
          width:200,
          color: Colors.amber,
          ),
        ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            setState(() {
              turns += 50;
              });
              },
            child: Icon(Icons.abc),
        ),
    );
  }
}
class C1 extends StatelessWidget {
  const C1({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.green,
    );  
  }
}
class C2 extends StatelessWidget {
  const C2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.red,
    );
  }
}