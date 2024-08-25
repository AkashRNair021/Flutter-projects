import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class Task {
  String text;
  DateTime createdAt;

  Task({required this.text, required this.createdAt});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();
  List<Task> _tasks = [];

  void _addTask() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _tasks.insert(0, Task(text: _textController.text, createdAt: DateTime.now()));
        _textController.clear();
      });
    }
  }

  void _editTask(Task task, String newText) {
    setState(() {
      _tasks[_tasks.indexOf(task)] = Task(text: newText, createdAt: task.createdAt);
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a task',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                Task task = _tasks[index];
                return ListTile(
                  title: Text(task.text),
                  subtitle: Text('Created at: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(task.createdAt)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              final _editController = TextEditingController(text: task.text);
                              return AlertDialog(
                                title: const Text('Edit Task'),
                                content: TextField(
                                  controller: _editController,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _editTask(task, _editController.text);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(task);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// void main() {
//   runApp(MyWidget());
// }

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('My App'),
//           backgroundColor: Colors.amber,
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(20),
//           child: ListView.builder(
//             itemCount: 50,
//             itemBuilder: (BuildContext context, index) {
          
//               return ListTile(
//                 leading: Icon(Icons.numbers),
//                 title: Text("List item ${index}"),
//                 onTap: () {
//                   print("object");
//                 },
//                 dense: true,
//                 contentPadding: EdgeInsets.all(10),
//                 tileColor: Colors.amber,
//                 focusColor: Colors.red,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
