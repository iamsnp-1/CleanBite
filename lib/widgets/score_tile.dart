import 'package:flutter/material.dart';

class ScoreTile extends StatelessWidget {
  final String title;
  final int value;
  final int max;

  const ScoreTile({
    super.key,
    required this.title,
    required this.value,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final progress = value / max;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text("$value / $max",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 6),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 900),
            builder: (_, value, __) {
              return LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey.shade200,
                color: Colors.green,
                minHeight: 8,
                borderRadius: BorderRadius.circular(6),
              );
            },
          ),
        ],
      ),
    );
  }
}
