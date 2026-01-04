import 'package:flutter/material.dart';
import 'login_screen.dart';


class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Logo
              Center(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7E7C8),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFB68656), width: 2),
                  ),
                  child: const Icon(Icons.restaurant, size: 40, color: Color(0xFF6C4825)),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Choose your language",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6C4825),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "भाषा चुनें",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6C4825),
                ),
              ),

              const SizedBox(height: 40),

              // English
              _buildLanguageCard(
                context,
                "En",
                "English",
                onTap: () {
                  Navigator.pushReplacement(
                  context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
      },

              ),

              const SizedBox(height: 20),

              // Hindi
              _buildLanguageCard(context, "हि", "Hindi"),
              const SizedBox(height: 20),

              // Marathi
              _buildLanguageCard(context, "म", "Marathi"),
              const SizedBox(height: 20),

              // Kannada
              _buildLanguageCard(context, "ಕ", "Kannada"),

              const Spacer(),

              const Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard(BuildContext context, String short, String full,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFFBEFCF),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color(0xFFE0BB85), width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4D9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                short,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF6C4825)),
              ),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  full,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF6C4825)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
