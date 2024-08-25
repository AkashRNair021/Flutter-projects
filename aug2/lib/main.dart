// import 'package:flutter/material.dart';

// void main(){
//   runApp(Third());
// }
// class Third extends StatefulWidget {
//   Third({super.key});

//   @override
//   State<Third> createState() {
//     return _ThirdState();
//   }
// }

// class _ThirdState extends State<Third> {
//   int count = 0;
//   String? option;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       child: Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 400,
//           width: 400,
//           color: Colors.green,
//         ),
//         Container(
//           height: 300,
//           width: 300,
//           color: Colors.blue,
//         )
//       ],
//     ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyWidget());
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shop)),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
             IconButton(onPressed: () {}, icon: Icon(Icons.notification_add)),
          ],
          title:Text("APPBAR"),
        ),
          body:Center(
            
          ),
        ),
        );
    
  }
}