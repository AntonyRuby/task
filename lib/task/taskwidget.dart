import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:task/src/models/utils.dart';
import 'package:task/task/edittaskpage.dart';
import 'package:task/task.dart';
import 'package:task/src/models/tasks.dart';

class Taskwidget extends StatelessWidget {
  final Task task;

  const Taskwidget({Key key, this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(task.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditTaskPage(
                          task: task,
                        )));
              },
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              onTap: () => deleteTask(context, task),
              caption: 'Delete',
              icon: Icons.delete,
            )
          ],
          child: GestureDetector(
            onTap: () => editTask(context, task),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Checkbox(
                    value: task.isDone,
                    onChanged: (_) {
                      final provider =
                          Provider.of<TaskProvider>(context, listen: false);
                      final isDone = provider.toggleTaskStatus(task);

                      Utils.showSnackBar(
                          context, isDone ? 'Completed' : 'Incomplete');
                    },
                    activeColor: Theme.of(context).primaryColor,
                    checkColor: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 2),
                      if (task.summary.isNotEmpty)
                        Text(
                          task.summary,
                          style: TextStyle(fontSize: 21, height: 1.5),
                        ),
                      SizedBox(height: 10),
                      Text(
                        "Created: ${task.createdTime}",
                        // Text(
                        // "Created: ${DateFormat('YYYY/MM/DD).format(task.createdTime)}",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      );

  void deleteTask(BuildContext context, Task task) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    provider.removeTask(task);

    Utils.showSnackBar(context, 'Deleted');
  }

  void editTask(BuildContext context, Task task) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditTaskPage(
                task: task,
              )));
}
