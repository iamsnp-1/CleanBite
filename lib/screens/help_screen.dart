import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Contact support at:\n\n📞 +91 90000 00000\n📧 support@hygienecert.app",
        ),
      ),
    );
  }
}
