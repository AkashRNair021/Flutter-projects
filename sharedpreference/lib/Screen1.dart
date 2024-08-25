import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // For formatting dates

class Screen1 extends StatefulWidget {
  final SharedPreferences prefs;

  const Screen1({Key? key, required this.prefs}) : super(key: key);

  @override
  _Screen1State createState() => _Screen1State();
}

class Task {
  String text;
  DateTime createdTime;

  Task({required this.text, required this.createdTime});

  // Convert Task to String for saving in SharedPreferences
  String toStorageString() {
    return '$text|${createdTime.toIso8601String()}';
  }

  // Convert String back to Task
  factory Task.fromStorageString(String storedString) {
    final parts = storedString.split('|');
    return Task(
      text: parts[0],
      createdTime: DateTime.parse(parts[1]),
    );
  }
}

class _Screen1State extends State<Screen1> {
  late TextEditingController _taskController;
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      _tasks = (widget.prefs.getStringList('tasks') ?? [])
          .map((taskString) => Task.fromStorageString(taskString))
          .toList();
    });
  }

  void _saveTasks() {
    widget.prefs.setStringList(
        'tasks', _tasks.map((task) => task.toStorageString()).toList());
  }

  void _addTask() {
    final taskText = _taskController.text;
    if (taskText.isNotEmpty) {
      final newTask = Task(text: taskText, createdTime: DateTime.now());
      setState(() {
        _tasks.add(newTask);
        _taskController.clear();
      });
      _saveTasks();
      _showSnackBar('Task added');
    } else {
      _showSnackBar('Task cannot be empty');
    }
  }

  void _editTask(Task task) {
    _taskController.text = task.text;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  hintText: 'Edit task',
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_taskController.text.isNotEmpty) {
                    setState(() {
                      task.text = _taskController.text;
                    });
                    _taskController.clear();
                    _saveTasks();
                    Navigator.of(context).pop(); // Close the bottom sheet
                    _showSnackBar('Task edited');
                  } else {
                    _showSnackBar('Task cannot be empty');
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteTask(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _tasks.remove(task);
              });
              _saveTasks();
              Navigator.of(context).pop(); // Close the dialog
              _showSnackBar('Task deleted');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple To-Do App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Enter a task',
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  Task task = _tasks[index];
                  return ListTile(
                    title: Text(task.text),
                    subtitle:
                        Text('Created: ${_formatDateTime(task.createdTime)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editTask(task),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteTask(task),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
