import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/models/user.dart';
import 'package:task/task.dart';
import 'package:task/src/models/tasks.dart';
import 'taskform.dart';

class AddNewTask extends StatefulWidget {
  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final formkey = GlobalKey<FormState>();
  String title = '';
  String summary = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text("Task Title"),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Task Title", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Sub Tasks"),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Task Title",
                  border: OutlineInputBorder(),
                  suffixIcon:
                      IconButton(icon: Icon(Icons.add), onPressed: () {})),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: MaterialButton(
                color: Colors.deepPurpleAccent[100],
                onPressed: () {},
                child: Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// class AddTasks extends StatefulWidget {
//   @override
//   _AddTasksState createState() => _AddTasksState();
// }

// class _AddTasksState extends State<AddTasks> {
//   final formkey = GlobalKey<FormState>();
//   String title = '';
//   String summary = '';

//   @override
//   Widget build(BuildContext context) => AlertDialog(
//           content: Form(
//         key: formkey,
//         child: SingleChildScrollView(
//             child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//               Row(
//                 children: [
//                   Text(
//                     "Add Task",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                   ),
//                   Spacer(),
//                   IconButton(
//                       icon: Icon(Icons.close),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       })
//                 ],
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Taskform(
//                 onChangedTitle: (title) => setState(() => this.title = title),
//                 onChangedSummary: (summary) =>
//                     setState(() => this.summary = summary),

//                 onSave: addTask,
//               ),
//             ])),
//       ));
//   void addTask() {
//     final isValid = formkey.currentState.validate();

//     if (!isValid) {
//       return;
//     } else {
//       final task = Task(
//         owner: user.userId,
//         createdTime: DateTime.now(),
//         title: title,
//         summary: summary,
//         id: DateTime.now().toString(),
//       );

//       final provider = Provider.of<TaskProvider>(context, listen: false);
//       provider.addTask(task);

//       Navigator.of(context).pop();
//     }
//   }
// }
