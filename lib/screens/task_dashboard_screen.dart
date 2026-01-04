import 'package:flutter/material.dart';
import 'hygiene_tasks_screen.dart';
import 'notifications_screen.dart';



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
      backgroundColor: const Color(0xFFF6F8F5),

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.black),
          onPressed: () {
            // TODO: Go to profile
          },
        ),
        title: const Text(
          "Welcome, Vendor!",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // TODO: Notifications
            },
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Certification Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF7F2),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFA7E0BC)),
              ),
              child: Column(
                children: const [
                  Text(
                    "Certification Status",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Not Certified Yet",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Complete tasks to earn certification",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Quick Actions
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
                children: [
                  dashboardTile(
                        Icons.verified_outlined,
                        "View Certificate",
                        "Access your certification",
                        () {
                          // TODO: Open certificate screen
                        },
                      ),

                  dashboardTile(
                      Icons.checklist,
                      "Hygiene Checklist",
                      "Complete daily tasks",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HygieneTasksScreen(),
                          ),
                        );
                      },
                    ),

                  dashboardTile(
                    Icons.school_outlined,
                    "Training",
                    "Access modules",
                    () {
                      // TODO: Training
                    },
                  ),
                  dashboardTile(
                    Icons.notifications_none,
                    "Notifications",
                    "View your updates",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() => currentIndex = i);
          // TODO: switch screens later
        },
        selectedItemColor: const Color(0xFF66B88F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: "Support",
          ),
        ],
      ),
    );
  }

  // ---------------- TILE ----------------
  Widget dashboardTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9FBF9),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE0E6E2)),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: const Color(0xFF66B88F)),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
