import 'package:flutter/cupertino.dart';
import 'package:task/cloud.dart';
import 'package:task/tasks.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks.where((task) => task.isDone == false).toList();

  List<Task> get taskCompleted =>
      _tasks.where((task) => task.isDone == true).toList();

  void setTask(List<Task> task) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tasks = task;
        notifyListeners();
      });

  void addTask(Task task) => Saveto.create(task);

  void removeTask(Task task) => Saveto.deleteTask(task);

  bool toggleTaskStatus(Task task) {
    task.isDone = !task.isDone;
    Saveto.updateTask(task);
    return task.isDone;
  }

  void updateTask(Task task, String title, String summary) {
    task.title = title;
    task.summary = summary;

    Saveto.updateTask(task);
  }
}
