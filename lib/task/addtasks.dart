import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/task.dart';
import 'package:task/task/tasks.dart';
import 'taskform.dart';

class AddTasks extends StatefulWidget {
  @override
  _AddTasksState createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  final formkey = GlobalKey<FormState>();
  String title = '';
  String summary = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
          content: Form(
        key: formkey,
        child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(
                children: [
                  Text(
                    "Add Task",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Taskform(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedSummary: (summary) =>
                    setState(() => this.summary = summary),
                onSave: addTask,
              ),
            ])),
      ));
  void addTask() {
    final isValid = formkey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final task = Task(
        createdTime: DateTime.now(),
        title: title,
        summary: summary,
        id: DateTime.now().toString(),
      );

      final provider = Provider.of<TaskProvider>(context, listen: false);
      provider.addTask(task);

      Navigator.of(context).pop();
    }
  }
}
