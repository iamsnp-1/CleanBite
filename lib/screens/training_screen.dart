import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Training Modules")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: List.generate(
          6,
          (i) => ListTile(
            leading: const Icon(Icons.play_circle),
            title: Text("Training Module ${i + 1}"),
            subtitle: const Text("1 min video"),
          ),
        ),
      ),
    );
  }
}
