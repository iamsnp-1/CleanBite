import 'package:flutter/material.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code")),
      body: const Center(
        child: Icon(Icons.qr_code_2, size: 160),
      ),
    );
  }
}
