import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskController extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get visibleTasks => _tasks.where((t) => !t.isHidden).toList();

  List<Task> get hiddenTasks => _tasks.where((t) => t.isHidden).toList();

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTask(Task task, String newTitle, DateTime newDate) {
    task.title = newTitle;
    task.date = newDate;
    notifyListeners();
  }

  void toggleHidden(Task task) {
    task.isHidden = !task.isHidden;
    notifyListeners();
  }
}
