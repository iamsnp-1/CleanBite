import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskId;
  const TaskDetailScreen({super.key, required this.taskId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  File? _photo;

  Future _capture() async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img != null) setState(() => _photo = File(img.path));
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final task = app.taskById(widget.taskId);

    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_photo != null) Image.file(_photo!, height: 250),
            const SizedBox(height: 14),
            ElevatedButton(onPressed: _capture, child: const Text('Capture Photo')),
            const Spacer(),
            ElevatedButton(
              onPressed: _photo == null
                  ? null
                  : () {
                      app.completeTask(task.id, media: _photo);
                      Navigator.pop(context);
                    },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
