import 'package:flutter/material.dart';
import 'vendor_photo_screen.dart';

class VendorNameScreen extends StatefulWidget {
  const VendorNameScreen({super.key});

  @override
  State<VendorNameScreen> createState() => _VendorNameScreenState();
}

class _VendorNameScreenState extends State<VendorNameScreen> {
  final TextEditingController nameController = TextEditingController();

  bool get isValid => nameController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Illustration placeholder (no assets)
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF1E6),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child: Icon(
                    Icons.storefront,
                    size: 90,
                    color: const Color(0xFF66B88F),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              const Text(
                "Join Us",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2F2F2F),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Let's get your stall certified",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7A7A7A),
                ),
              ),

              const SizedBox(height: 40),

              // Label
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Full Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F2F2F),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Input
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE0E6E2)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: "Enter Name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.person_outline,
                      color: Color(0xFF9DB6A8),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isValid
                      ? () {
                          // TODO: Navigate to next onboarding step
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const VendorPhotoScreen(),
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
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F2F2F),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: i == 0
                          ? const Color(0xFF66B88F)
                          : const Color(0xFFD0DAD5),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
