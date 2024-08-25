import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

void main() {
  runApp(
    MaterialApp(
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Drawer"),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.party_mode), text: "Camera"),
            Tab(icon: Icon(Icons.settings), text: "Settings"),
          ]),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              child: Text("profile"),
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Setting"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Privacy"),
              onTap: () {},
            ),
            ListTile(
              title: Text("About"),
              onTap: () {},
            ),
          ],
        )),
        body: TabBarView(
          children: [
            Container(color: Colors.blue),
            Container(color: Colors.red),
            Container(color: Colors.green),
          ],
        ),
      ),
    );
  }
}
