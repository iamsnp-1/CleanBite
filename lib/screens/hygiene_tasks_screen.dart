import 'package:flutter/material.dart';
import 'task_detail_screen2.dart';

class HygieneTasksScreen extends StatefulWidget {
  const HygieneTasksScreen({super.key});

  @override
  State<HygieneTasksScreen> createState() => _HygieneTasksScreenState();
}

class _HygieneTasksScreenState extends State<HygieneTasksScreen> {
  int score = 0;

  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Personal Hygiene",
      "time": "5 mins",
      "points": 10,
      "icon": Icons.clean_hands,
      "completed": false,
    },
    {
      "title": "Utensil Cleanliness",
      "time": "10 mins",
      "points": 15,
      "icon": Icons.restaurant,
      "completed": false,
    },
    {
      "title": "Water Safety",
      "time": "5 mins",
      "points": 10,
      "icon": Icons.water_drop,
      "completed": false,
    },
    {
      "title": "Food Storage",
      "time": "15 mins",
      "points": 20,
      "icon": Icons.inventory_2,
      "completed": false,
    },
    {
      "title": "Waste Disposal",
      "time": "5 mins",
      "points": 10,
      "icon": Icons.delete,
      "completed": false,
    },
    {
      "title": "Pest Control",
      "time": "10 mins",
      "points": 15,
      "icon": Icons.bug_report,
      "completed": false,
    },
    {
      "title": "Cooking & Freshness",
      "time": "20 mins",
      "points": 20,
      "icon": Icons.local_fire_department,
      "completed": false,
    },
  ];

  bool get isCertified => score >= 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Hygiene Certification",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- PROFILE ----------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF7F2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Vendor Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Chip(
                        label: Text(
                          isCertified
                              ? "Certified"
                              : "Not Certified Yet",
                        ),
                        backgroundColor: isCertified
                            ? const Color(0xFFA7E0BC)
                            : const Color(0xFFFFF3C4),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------- SCORE ----------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Current Score",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        "$score / 100",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: score / 100,
                    minHeight: 10,
                    backgroundColor: const Color(0xFFE6E6E6),
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFF66B88F),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Complete to Get Certified",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 16),

            ...tasks.map((task) => taskTile(task)).toList(),
          ],
        ),
      ),
    );
  }

  // ---------------- TASK TILE ----------------
  Widget taskTile(Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFA7E0BC),
            child: Icon(task["icon"], color: Colors.black),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task["title"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${task["time"]}  •  +${task["points"]} Points",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: task["completed"]
                ? null
                : () async {
                    final completed = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskDetailScreen(
                          taskTitle: task["title"],
                        ),
                      ),
                    );

                    if (completed == true) {
                      setState(() {
                        task["completed"] = true;
                        score += task["points"] as int;
                      });
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: task["completed"]
                  ? Colors.grey.shade400
                  : const Color(0xFFA7E0BC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              task["completed"] ? "Done" : "Start",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
