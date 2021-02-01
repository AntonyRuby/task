import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/task.dart';
import 'package:task/taskform.dart';
import 'package:task/tasks.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({Key key, @required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final formkey = GlobalKey<FormState>();

  String title;
  String summary;

  @override
  void initState() {
    super.initState();

    title = widget.task.title;
    summary = widget.task.summary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Edit"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<TaskProvider>(context, listen: false);
                provider.removeTask(widget.task);
                Navigator.of(context).pop();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: formkey,
          child: Taskform(
            title: title,
            summary: summary,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedSummary: (summary) =>
                setState(() => this.summary = summary),
            onSave: saveTask,
          ),
        ),
      ),
    );
  }

  void saveTask() {
    final isValid = formkey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TaskProvider>(context, listen: false);
      provider.updateTask(widget.task, title, summary);

      Navigator.of(context).pop();
    }
  }
}
