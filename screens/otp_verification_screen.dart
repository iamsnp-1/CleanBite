import 'dart:async';
import 'package:flutter/material.dart';
import 'vendor_name_screen.dart';


class OTPVerificationScreen extends StatefulWidget {
  final String phone;
  const OTPVerificationScreen({super.key, required this.phone});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String otp = "";
  int timer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer > 0) {
        setState(() => timer--);
      } else {
        t.cancel();
      }
    });
  }

  void addDigit(String d) {
    if (otp.length < 6) {
      setState(() => otp += d);
    }
  }

  void removeDigit() {
    if (otp.isNotEmpty) {
      setState(() => otp = otp.substring(0, otp.length - 1));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final digits = otp.padRight(6).split("");

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Back button
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF2F2F2F)),
              onPressed: () => Navigator.pop(context),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Enter Verification\nCode",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2F2F2F),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "A 6-digit code has been sent to your mobile\nnumber ${widget.phone}.",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7A7A7A),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // OTP boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (i) {
                return Column(
                  children: [
                    Text(
                      digits[i],
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F2F2F),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 2,
                      margin: const EdgeInsets.only(top: 6),
                      color: const Color(0xFFE0E6E2),
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 30),

            // Resend text
            Center(
              child: Text(
                timer > 0
                    ? "Didn't receive the code? Resend in 00:${timer.toString().padLeft(2, '0')}"
                    : "Didn't receive the code? Resend",
                style: TextStyle(
                  color: timer > 0
                      ? const Color(0xFF7A7A7A)
                      : const Color(0xFF66B88F),
                ),
              ),
            ),

            const Spacer(),

            // Keypad
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF4F5F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  keypadRow(["1", "2", "3"]),
                  keypadRow(["4", "5", "6"]),
                  keypadRow(["7", "8", "9"]),
                  keypadRow(["", "0", "<"]),

                  const SizedBox(height: 16),

                  // Verify Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: otp.length == 6
                            ? () {
                                // TODO: OTP verification logic
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const VendorNameScreen(),
                                  ),
                                );

                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: otp.length == 6
                              ? const Color(0xFF66B88F)
                              : const Color(0xFFCDDAD2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2F2F2F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget keypadRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((k) {
          if (k == "<") {
            return keypadButton(
              child: const Icon(Icons.backspace_outlined),
              onTap: removeDigit,
            );
          }
          if (k.isEmpty) {
            return const SizedBox(width: 70);
          }
          return keypadButton(
            child: Text(
              k,
              style: const TextStyle(
                fontSize: 26,
                color: Color(0xFF2F2F2F),
              ),
            ),
            onTap: () => addDigit(k),
          );
        }).toList(),
      ),
    );
  }

  Widget keypadButton({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        height: 70,
        child: Center(child: child),
      ),
    );
  }
}
