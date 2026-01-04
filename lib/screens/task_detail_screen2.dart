import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskTitle;

  const TaskDetailScreen({super.key, required this.taskTitle});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool videoUploaded = false;
  bool photoUploaded = false;

  bool noSmoking = false;
  bool handsWashed = false;

  bool get canSubmit =>
      videoUploaded && photoUploaded && noSmoking && handsWashed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          widget.taskTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- VIDEO CARD ----------------
            stepTitle(1, "Video Proof"),
            proofCard(
              icon: Icons.videocam,
              title: "Upload short video showing:",
              bullets: const [
                "Clean clothes & apron",
                "Hair covered (cap/cloth)",
              ],
              buttonText: videoUploaded ? "Video Recorded" : "Record Video",
              onTap: () {
                setState(() => videoUploaded = true);
              },
            ),

            const SizedBox(height: 24),

            // ---------------- PHOTO CARD ----------------
            stepTitle(2, "Photo Proof"),
            proofCard(
              icon: Icons.camera_alt,
              title: "Upload photo of:",
              bullets: const [
                "Clean hands & trimmed nails",
              ],
              buttonText: photoUploaded ? "Photo Captured" : "Take Photo",
              onTap: () {
                setState(() => photoUploaded = true);
              },
            ),

            const SizedBox(height: 24),

            // ---------------- SELF CHECK ----------------
            stepTitle(3, "Self-check confirmation"),
            checkboxTile(
              value: noSmoking,
              onChanged: (v) => setState(() => noSmoking = v),
              title: "No smoking/spitting while cooking",
              subtitle:
                  "I confirm I will maintain a smoke-free zone.",
              icon: Icons.smoke_free,
            ),
            checkboxTile(
              value: handsWashed,
              onChanged: (v) => setState(() => handsWashed = v),
              title: "Hands washed before food handling",
              subtitle: "I confirm my hands are clean.",
              icon: Icons.clean_hands,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // ---------------- SUBMIT BUTTON ----------------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: canSubmit
              ? () {
                  Navigator.pop(context, true);
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            disabledBackgroundColor: Colors.grey.shade400,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Submit Task for Review →",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- COMPONENTS ----------------

  Widget stepTitle(int step, String text) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: const Color(0xFFE0F3E8),
          child: Text(
            "$step",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF66B88F),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget proofCard({
    required IconData icon,
    required String title,
    required List<String> bullets,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE0E6E2),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFEFF7F2),
              child: Icon(icon, color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text("• $b",
                  style: const TextStyle(color: Colors.grey)),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: 18, color: Colors.black),
              label: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA7E0BC),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget checkboxTile({
    required bool value,
    required ValueChanged<bool> onChanged,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: (v) => onChanged(v!),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(subtitle),
        secondary: Icon(icon),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
