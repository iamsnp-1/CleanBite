import 'package:flutter/material.dart';
import 'task_detail_screen.dart';
import '../utils/page_transition.dart';

class TodaysHygieneChecklistScreen extends StatefulWidget {
  const TodaysHygieneChecklistScreen({super.key});

  @override
  State<TodaysHygieneChecklistScreen> createState() =>
      _TodaysHygieneChecklistScreenState();
}

class _TodaysHygieneChecklistScreenState
    extends State<TodaysHygieneChecklistScreen> {
  int score = 0;

  final List<Map<String, dynamic>> todayTasks = [
    {
      "title": "Personal Hygiene",
      "time": "5 mins",
      "points": 15,
      "icon": Icons.clean_hands,
      "status": "NOT STARTED",
    },
    {
      "title": "Water Safety",
      "time": "3 mins",
      "points": 10,
      "icon": Icons.water_drop,
      "status": "NOT STARTED",
    },
    {
      "title": "Cooking & Freshness",
      "time": "12 mins",
      "points": 25,
      "icon": Icons.restaurant,
      "status": "NOT STARTED",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Today's Hygiene Checklist",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF66B88F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: "Progress"),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), label: "Support"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Complete today’s tasks to improve your hygiene score and reach certification (80+ required)",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            overallScoreCard(),
            const SizedBox(height: 20),

            ...todayTasks.map(taskCard).toList(),

            const SizedBox(height: 32),

            const Text(
              "Hygiene Standards Overview",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Point values for compliance categories",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 16),
            ...overviewTiles,
          ],
        ),
      ),
    );
  }

  // ---------------- OVERALL SCORE ----------------
  Widget overallScoreCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFEFF7F2),
            child: Icon(Icons.bar_chart),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "OVERALL SCORE",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "$score / 100",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Text("Not Started"),
          ),
        ],
      ),
    );
  }

  // ---------------- TASK CARD ----------------
  Widget taskCard(Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFEFF7F2),
            child: Icon(task["icon"], color: const Color(0xFF66B88F)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task["title"],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${task["time"]}  •  Contributes to hygiene score",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F3F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    task["status"],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final done = await Navigator.push(
                context,
                FadeSlideRoute(
                  page: TaskDetailScreen(
                    taskTitle: task["title"],
                  ),
                ),
              );

              if (done == true) {
                setState(() {
                  task["status"] = "COMPLETED";
                  score += task["points"] as int;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA7E0BC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Start Task",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- OVERVIEW ----------------

final List<Widget> overviewTiles = [
  overviewTile("Personal Hygiene", "+15 pts"),
  overviewTile("Utensil Cleanliness", "+15 pts"),
  overviewTile("Water Safety", "+10 pts"),
  overviewTile("Food Storage", "+15 pts"),
  overviewTile("Waste Disposal", "+10 pts"),
  overviewTile("Pest Control", "+10 pts"),
  overviewTile("Cooking & Freshness", "+25 pts"),
];

Widget overviewTile(String title, String points) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          points,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.green,
          ),
        ),
      ],
    ),
  );
}
