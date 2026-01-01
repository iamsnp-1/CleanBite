import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/task_item.dart';

class AppState extends ChangeNotifier {
  final List<TaskItem> tasks = [
    TaskItem(id: 'utensils', title: 'Upload photo of clean utensils', points: 10, timeLimit: Duration(hours: 24)),
    TaskItem(id: 'cleaning_video', title: 'Upload video of cleaning area', points: 15, timeLimit: Duration(hours: 48)),
    TaskItem(id: 'gloves', title: 'Upload photo wearing gloves', points: 10, timeLimit: Duration(hours: 24)),
  ];

  String vendorName = '';
  int get currentScore => tasks.where((t) => t.completed).fold(0, (a, b) => a + b.points);

  void completeTask(String id, {File? media, Position? position}) {
    final t = tasks.firstWhere((e) => e.id == id);
    t.completed = true;
    t.media = media;
    t.position = position;
    notifyListeners();
  }

  TaskItem taskById(String id) => tasks.firstWhere((e) => e.id == id);
}
