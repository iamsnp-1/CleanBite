import 'dart:io';
import 'package:geolocator/geolocator.dart';

class TaskItem {
  final String id;
  final String title;
  final int points;
  final Duration timeLimit;
  bool completed;
  File? media;
  Position? position;

  TaskItem({
    required this.id,
    required this.title,
    required this.points,
    required this.timeLimit,
    this.completed = false,
  });
}
