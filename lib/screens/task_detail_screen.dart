import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskTitle;

  const TaskDetailScreen({super.key, required this.taskTitle});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool videoDone = false;
  bool photoDone = false;
  bool check1 = false;
  bool check2 = false;

  bool get canSubmit {
    if (widget.taskTitle == "Personal Hygiene") {
      return videoDone && photoDone && check1 && check2;
    }
    return videoDone && photoDone;
  }

  @override
  Widget build(BuildContext context) {
    final config = taskConfig[widget.taskTitle]!;

    return Scaffold(
      backgroundColor: Colors.white,

      // ---------- APP BAR ----------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "${widget.taskTitle} Task",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ---------- BODY ----------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // -------- VIDEO --------
            sectionTitle("Record Video"),
            ...config["video"]!.map<Widget>((text) => bullet(text)).toList(),

            actionButton(
              icon: Icons.videocam,
              label: "Record Video",
              completed: videoDone,
              onTap: () {
                setState(() => videoDone = true);
              },
            ),

            divider(),

            // -------- PHOTO --------
            sectionTitle("Take Photo"),
            ...config["photo"]!.map<Widget>((text) => bullet(text)).toList(),

            actionButton(
              icon: Icons.camera_alt,
              label: "Take Photo",
              completed: photoDone,
              onTap: () {
                setState(() => photoDone = true);
              },
            ),

            if (widget.taskTitle == "Personal Hygiene") ...[
              divider(),
              sectionTitle("Self-Check"),
              checkboxTile(
                "No smoking/spitting while cooking",
                check1,
                (v) => setState(() => check1 = v),
              ),
              checkboxTile(
                "Hands washed before handling food",
                check2,
                (v) => setState(() => check2 = v),
              ),
            ],

            const SizedBox(height: 80),
          ],
        ),
      ),

      // ---------- SUBMIT ----------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedScale(
          scale: canSubmit ? 1 : 0.96,
          duration: const Duration(milliseconds: 200),
          child: ElevatedButton(
            onPressed: canSubmit
                ? () => Navigator.pop(context, true)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Submit Task for Review",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF66B88F), size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget actionButton({
    required IconData icon,
    required String label,
    required bool completed,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: completed ? null : onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFA7E0BC),
        disabledBackgroundColor: const Color(0xFFEFF7F2),
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }

  Widget checkboxTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (v) => onChanged(v!),
            activeColor: const Color(0xFF66B88F),
          ),
          Expanded(
            child: Text(title),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Divider(height: 1),
    );
  }
}

// ---------- TASK CONFIG ----------

final Map<String, Map<String, List<String>>> taskConfig = {
  "Personal Hygiene": {
    "video": [
      "Clean clothes & apron",
      "Hair covered (cap/cloth)",
    ],
    "photo": [
      "Clean hands & trimmed nails",
    ],
  },
  "Utensil Cleanliness": {
    "video": [
      "Record a video of you washing your utensils",
    ],
    "photo": [
      "Clean utensils after washing",
      "Separate utensils for raw and cooked food",
    ],
  },
  "Water Safety": {
    "video": [
      "Record a video of your water source (tap, RO, or filter)",
    ],
    "photo": [
      "Show your covered water storage container",
    ],
  },
};
