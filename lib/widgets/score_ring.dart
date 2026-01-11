import 'package:flutter/material.dart';

class ScoreRing extends StatelessWidget {
  final int score;
  const ScoreRing({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final progress = score / 100;

    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress),
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutCubic,
        builder: (_, value, __) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.green,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$score",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "/ 100",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Hygiene Score",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
