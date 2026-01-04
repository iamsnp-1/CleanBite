import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'stall_registration_screen.dart';
class VendorPhotoScreen extends StatefulWidget {
  const VendorPhotoScreen({super.key});

  @override
  State<VendorPhotoScreen> createState() => _VendorPhotoScreenState();
}

class _VendorPhotoScreenState extends State<VendorPhotoScreen> {
  File? _photo;

  Future<void> _capturePhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (picked != null) {
      setState(() {
        _photo = File(picked.path);
      });
    }
  }

  void _continue() {
    // TODO: Navigate to next onboarding step
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const StallRegistrationScreen(),
  ),
);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Skip button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _continue,
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7A7A7A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Illustration placeholder
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEFF7F2),
                ),
                child: const Icon(
                  Icons.storefront,
                  size: 80,
                  color: Color(0xFF66B88F),
                ),
              ),

              const SizedBox(height: 36),

              const Text(
                "Welcome! Let's get\nyou started.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2F2F2F),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "First, let's add a profile photo.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7A7A7A),
                ),
              ),

              const SizedBox(height: 36),

              // Upload box
              GestureDetector(
                onTap: _capturePhoto,
                child: Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFD0DAD5),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: _photo == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Color(0xFF9DB6A8),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Tap to add photo",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2F2F2F),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Upload a clear profile photo of yourself",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF7A7A7A),
                              ),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _photo!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Upload photo button (light)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _capturePhoto,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFFE6F4EC),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Upload Photo",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF66B88F),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _photo != null ? _continue : null,
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
                      color: i == 1
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
