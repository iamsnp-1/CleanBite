import 'package:flutter/material.dart';
import 'task_dashboard_screen.dart';


class RegistrationSubmittedScreen extends StatelessWidget {
  const RegistrationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              // Success Icon
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF7F2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xFF66B88F),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              const Text(
                "Registration\nSubmitted",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2F2F2F),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "Welcome to the Platform!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F2F2F),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Your details have been received and are now pending review. "
                "You can get a head start on the process now.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7A7A7A),
                ),
              ),

              const Spacer(),

              // Start Hygiene Tasks Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to Task Dashboard
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TaskDashboardScreen(),
                        ),
                      );

                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFFA7E0BC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Start Hygiene Tasks",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F2F2F),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Progress dots (final step)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: i == 3
                          ? const Color(0xFF66B88F)
                          : const Color(0xFFD0DAD5),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
