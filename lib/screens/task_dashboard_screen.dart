import 'package:flutter/material.dart';
import 'hygiene_tasks_screen.dart';
import 'notifications_screen.dart';
import 'certificate_screen.dart';
import 'training_screen.dart';
import 'progress_screen.dart';
import 'help_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'qr_screen.dart';




class TaskDashboardScreen extends StatefulWidget {
  const TaskDashboardScreen({super.key});

  @override
  State<TaskDashboardScreen> createState() => _TaskDashboardScreenState();
}

class _TaskDashboardScreenState extends State<TaskDashboardScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF8),

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Rajesh Kumar",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Golden Chaat Corner",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_rounded),
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QRScreen()),
            );
          },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xFFD9F1E3),
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),

          
        ],
      ),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // -------- STATUS --------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2E5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "● Hygiene in Progress",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------- QUICK ACTIONS --------
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                actionTile(
                  context,
                  icon: Icons.checklist,
                  title: "Hygiene Checklist",
                  subtitle: "Complete daily tasks",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TodaysHygieneChecklistScreen(),
                      ),
                    );
                  },
                ),
                actionTile(
                  context,
                  icon: Icons.workspace_premium,
                  title: "View Certificate",
                  subtitle: "Download credentials",
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CertificateScreen()),
                    ),
                ),
                actionTile(
                  context,
                  icon: Icons.school,
                  title: "Training",
                  subtitle: "Access 12 modules",
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TrainingScreen()),
                    ),
                ),
                actionTile(
                  context,
                  icon: Icons.notifications,
                  title: "Notifications",
                  subtitle: "3 new updates",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ),
                    );
                  },
                  badge: true,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // -------- STANDARDS --------
            const Text(
              "Hygiene Standards You May Be Checked On",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Any 3 of these will be assigned daily",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            ...standards.map((item) => standardTile(item)).toList(),
          ],
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed, // 🔥 IMPORTANT
  currentIndex: 0,

  showSelectedLabels: true,
  showUnselectedLabels: true,

  selectedItemColor: const Color(0xFF66B88F),
  unselectedItemColor: Colors.grey,

  selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),

  onTap: (index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProgressScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HelpScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
      );
    }
  },

  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.show_chart),
      label: "Progress",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.help_outline),
      label: "Help",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ],
),

    );
  }

  // ---------------- COMPONENTS ----------------

  static Widget actionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool badge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFA7E0BC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Icon(icon, size: 36),
                if (badge)
                  const Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  static Widget standardTile(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: item["bg"],
            child: Icon(item["icon"], color: item["color"]),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  item["time"],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            item["points"],
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- DATA ----------------

final List<Map<String, dynamic>> standards = [
  {
    "title": "Personal Hygiene",
    "time": "Est. 5 mins",
    "points": "+15 pts",
    "icon": Icons.clean_hands,
    "color": Colors.blue,
    "bg": const Color(0xFFE6F0FF),
    
  },
  {
    "title": "Utensil Cleanliness",
    "time": "Est. 8 mins",
    "points": "+15 pts",
    "icon": Icons.restaurant,
    "color": Colors.teal,
    "bg": const Color(0xFFE6FAF8),
  },
  {
    "title": "Water Safety",
    "time": "Est. 3 mins",
    "points": "+10 pts",
    "icon": Icons.water_drop,
    "color": Colors.blueAccent,
    "bg": const Color(0xFFEAF3FF),
  },
  {
    "title": "Food Storage",
    "time": "Est. 10 mins",
    "points": "+15 pts",
    "icon": Icons.inventory_2,
    "color": Colors.orange,
    "bg": const Color(0xFFFFF2E5),
  },
  {
    "title": "Waste Disposal",
    "time": "Est. 5 mins",
    "points": "+10 pts",
    "icon": Icons.delete,
    "color": Colors.grey,
    "bg": const Color(0xFFF1F1F1),
  },
  {
    "title": "Pest Control",
    "time": "Est. 5 mins",
    "points": "+10 pts",
    "icon": Icons.bug_report,
    "color": Colors.red,
    "bg": const Color(0xFFFFEAEA),
  },
  {
    "title": "Cooking & Freshness",
    "time": "Est. 12 mins",
    "points": "+25 pts",
    "icon": Icons.local_fire_department,
    "color": Colors.deepOrange,
    "bg": const Color(0xFFFFEFE8),
  },
];
