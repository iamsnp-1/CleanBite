import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  bool get isValid => phoneController.text.length == 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.verified, color: Color(0xFF66B88F), size: 26),
                    SizedBox(width: 8),
                    Text(
                      "HygieneCert",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2F2F2F),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 42),

                // Illustration (no image, theme-matched)
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF1E6),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Center(
                    child: Container(
                      height: 180,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 18,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFF66B88F),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                const Text(
                  "Welcome, Vendor!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2F2F2F),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Enter your mobile number to log in",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7A7A7A),
                  ),
                ),

                const SizedBox(height: 30),

                // Phone input
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xFFE0E6E2)),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "+91",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2F2F2F),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "Enter your 10-digit number",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                // Send OTP button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isValid
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OTPVerificationScreen(
                                  phone: "+91 ${phoneController.text}",
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFFA7E0BC),
                      disabledBackgroundColor:
                          const Color(0xFFCDDAD2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Send OTP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2F2F2F),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                const Text(
                  "Having trouble? Contact Support",
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
