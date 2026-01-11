import 'package:flutter/material.dart';
import '../widgets/score_ring.dart';
import '../widgets/score_tile.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Progress",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScoreRing(score: 0),
            SizedBox(height: 24),
            _GoalCard(),
            SizedBox(height: 30),
            Text(
              "Score Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            ScoreTile(title: "Personal Hygiene", value: 0, max: 15),
            ScoreTile(title: "Utensil Cleanliness", value: 0, max: 25),
            ScoreTile(title: "Food Handling", value: 0, max: 15),
            ScoreTile(title: "Storage", value: 0, max: 15),
            ScoreTile(title: "Waste Management", value: 0, max: 10),
          ],
        ),
      ),
    );
  }
}
class _GoalCard extends StatelessWidget {
  const _GoalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFAF2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFB7E4C7),
            child: Icon(Icons.verified, color: Colors.green),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Goal: 80 Points",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "10 more tasks to unlock certification",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
