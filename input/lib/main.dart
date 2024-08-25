import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyWidget());
}



class MyWidget extends StatelessWidget {
  MyWidget({super.key});
  final TextEditingController controller =
      TextEditingController(text: "Initial text");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
            width: 300,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                print(value);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue,
                  border: OutlineInputBorder(),
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: Colors.red),
                  labelText: "Hello"),
            ),
          ),
          TextButton(
            onPressed: () {
              print(controller.text);
              controller.clear();
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
