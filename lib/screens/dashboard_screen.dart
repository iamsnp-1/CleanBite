import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'task_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        children: app.tasks.map((t) {
          return Card(
            child: ListTile(
              title: Text(t.title),
              subtitle: Text('+${t.points} points'),
              trailing: ElevatedButton(
                child: const Text('Start'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TaskDetailScreen(taskTitle: t.id)),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
