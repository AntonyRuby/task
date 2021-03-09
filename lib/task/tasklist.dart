import 'package:flutter/material.dart';
import 'package:task/task.dart';
import 'package:task/task/taskwidget.dart';
import 'package:provider/provider.dart';

class Tasklist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final tasks = provider.tasks;

    return tasks.isEmpty
        ? Center(
            child: Text(
              "No Task",
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
