import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'registration_submitted_screen.dart';

class StallRegistrationScreen extends StatefulWidget {
  const StallRegistrationScreen({super.key});

  @override
  State<StallRegistrationScreen> createState() =>
      _StallRegistrationScreenState();
}

class _StallRegistrationScreenState extends State<StallRegistrationScreen> {
  final TextEditingController stallNameCtrl = TextEditingController();
  final TextEditingController ownerNameCtrl = TextEditingController();

  String? stallType;

  // LOCATION
  String locationText = "Auto-detecting location...";
  Position? currentPosition;
  bool isDetecting = false;

  // TIME
  TimeOfDay fromTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay toTime = const TimeOfDay(hour: 17, minute: 0);

  bool get isValid =>
      stallNameCtrl.text.isNotEmpty &&
      stallType != null &&
      currentPosition != null;

  // ---------------- LOCATION ----------------

  Future<void> detectLocation() async {
    setState(() => isDetecting = true);

    if (!await Geolocator.isLocationServiceEnabled()) {
      setState(() {
        locationText = "Location services disabled";
        isDetecting = false;
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationText = "Location permission denied permanently";
        isDetecting = false;
      });
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = pos;
      locationText =
          "Lat: ${pos.latitude.toStringAsFixed(4)}, "
          "Lng: ${pos.longitude.toStringAsFixed(4)}";
      isDetecting = false;
    });
  }

  // ---------------- TIME PICKER ----------------

  Future<void> pickTime(bool isFrom) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isFrom ? fromTime : toTime,
    );
    if (picked != null) {
      setState(() {
        isFrom ? fromTime = picked : toTime = picked;
      });
    }
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF2F2F2F)),
        title: const Text(
          "Register Your Stall",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF2F2F2F),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label("Outlet Name"),
            inputBox(stallNameCtrl, "e.g. Grandma's Kitchen", Icons.storefront),

            const SizedBox(height: 20),


            label("Outlet Type"),
            dropdownBox(),

            const SizedBox(height: 20),

            label("GPS Location"),
            gpsBox(),

            const SizedBox(height: 20),

            label("Operating Hours"),
            Row(
              children: [
                timeBox("From", fromTime, () => pickTime(true)),
                const SizedBox(width: 16),
                timeBox("To", toTime, () => pickTime(false)),
              ],
            ),

            const Spacer(),

            // CONTINUE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isValid
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const RegistrationSubmittedScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA7E0BC),
                  disabledBackgroundColor: const Color(0xFFCDDAD2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
          ],
        ),
      ),
    );
  }

  // ---------------- COMPONENTS ----------------

  Widget label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.w600)),
      );

  Widget inputBox(
      TextEditingController ctrl, String hint, IconData icon) {
    return Container(
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
              controller: ctrl,
              onChanged: (_) => setState(() {}),
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: hint),
            ),
          ),
          Icon(icon, color: const Color(0xFF66B88F)),
        ],
      ),
    );
  }

  Widget dropdownBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E6E2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: stallType,
          hint: const Text("Select stall type"),
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: "Street Food", child: Text("Street Food")),
            DropdownMenuItem(value: "Cafe", child: Text("Cafe")),
            DropdownMenuItem(value: "Restaurant", child: Text("Restaurant")),
            DropdownMenuItem(value: "Food Truck", child: Text("Food Truck")),
          ],
          onChanged: (v) {
            setState(() {
              stallType = v;
            });
          },
        ),
      ),
    );
  }

  Widget gpsBox() {
    return GestureDetector(
      onTap: detectLocation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F5F7),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE0E6E2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFF66B88F)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                isDetecting ? "Detecting..." : locationText,
                style: const TextStyle(color: Color(0xFF7A7A7A)),
              ),
            ),
            const Text(
              "Detect",
              style: TextStyle(
                color: Color(0xFF66B88F),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeBox(String label, TimeOfDay time, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE0E6E2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF7A7A7A))),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    time.format(context),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const Icon(Icons.access_time, size: 18),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
