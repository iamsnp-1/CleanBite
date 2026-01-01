import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text('Welcome', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Vendor Name'),
                    validator: (v) => v!.isEmpty ? 'Enter name' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<AppState>(context, listen: false).vendorName = _nameController.text;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
                      }
                    },
                    child: const Text('Start'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
