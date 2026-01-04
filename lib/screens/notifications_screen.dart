import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool allRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => allRead = true);
            },
            child: const Text(
              "Mark all as read",
              style: TextStyle(
                color: Color(0xFF66B88F),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            sectionTitle("TODAY"),

            notificationTile(
              icon: Icons.checklist,
              title: "New Task Available!",
              subtitle: "Earn +10 points.",
              time: "10m ago",
              unread: !allRead,
            ),

            notificationTile(
              icon: Icons.priority_high,
              title: "1 hour left for Cleaning Video task.",
              subtitle: "Don't miss the deadline.",
              time: "2h ago",
              unread: !allRead,
            ),

            const SizedBox(height: 24),

            sectionTitle("YESTERDAY"),

            notificationTile(
              icon: Icons.lock_open,
              title: "Complete tasks to unlock certification.",
              subtitle: "You're making great progress!",
              time: "Yesterday",
              unread: false,
            ),

            notificationTile(
              icon: Icons.emoji_events,
              title: "You earned +10 points!",
              subtitle: "Your score has been updated.",
              time: "Yesterday",
              unread: false,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- COMPONENTS ----------------

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget notificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required bool unread,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Icon
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFEFF7F2),
            child: Icon(icon, color: const Color(0xFF66B88F)),
          ),

          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          // Time + unread dot
          Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 6),
              if (unread)
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: Color(0xFF66B88F),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
