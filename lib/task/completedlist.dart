import 'package:flutter/material.dart';
import 'package:task/src/models/user.dart';
import 'package:task/task.dart';
import 'package:task/task/taskwidget.dart';
import 'package:provider/provider.dart';

class Completedlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final tasks = provider.taskCompleted
        .where((element) => element.owner == user.userId)
        .toList();

    return tasks.isEmpty
        ? Center(
            child: Text(
              "No Completed Tasks",
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(
                  height: 16,
                ),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Taskwidget(
                task: task,
              );
            });
  }
}
