import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            backgroundColor: Colors.amber,
            barrierColor: Colors.red,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            elevation: 5,
            enableDrag: false, // `showDragHandle` is not valid; removed it.
            builder: (context) {
              return Container(
                height: 200,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text('Hello, World!'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );

          final isConfirm = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text("You tapped the box"),
                backgroundColor: Colors.amber,
                icon: const Icon(
                  Icons.warning,
                  color: Color.fromARGB(255, 124, 8, 240),
                  size: 60,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Confirm"),
                  ),
                ],
              );
            },
          );

          if (isConfirm == true) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text("Actions identified"),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.amber,
                action: SnackBarAction(
                  label: "UNDO",
                  onPressed: () {
                    // Action for undoing the confirmation.
                  },
                ),
              ),
            );
          }
        },
        child: const Center(
          child: Text("Tap the message to quit"),
        ),
      ),
    );
  }
}
