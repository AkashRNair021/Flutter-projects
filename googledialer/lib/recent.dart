import 'package:flutter/material.dart';

class RecentPage extends StatelessWidget {
  final List<Map<String, String>> recentCalls;

  RecentPage({required this.recentCalls});

  @override
  Widget build(BuildContext context) {
    return recentCalls.isEmpty
        ? Center(child: Text('No recent calls'))
        : ListView.builder(
            itemCount: recentCalls.length,
            itemBuilder: (context, index) {
              final call = recentCalls[index];
              return ListTile(
                title: Text(call['name'] ?? 'Unknown'),
                subtitle: Text('${call['phone'] ?? ''}\n${call['date'] ?? ''} ${call['time'] ?? ''}'),
                leading: Icon(Icons.history),
                onTap: () {
                  // Optionally handle tap events, e.g., show call details
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Call Details'),
                        content: Text('Name: ${call['name']}\nPhone: ${call['phone']}\nDate: ${call['date']}\nTime: ${call['time']}'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
  }
}