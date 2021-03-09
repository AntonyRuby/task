import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/task/tasks.dart';
import 'utils.dart';

class Saveto {
  static Future<String> create(Task task) async {
    final docTask = FirebaseFirestore.instance.collection('task').doc();

    task.id = docTask.id;
    await docTask.set(task.toJson());

    return docTask.id;
  }

  static Stream<List<Task>> readTask() => FirebaseFirestore.instance
      .collection('task')
      .orderBy(Taskfield.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Task.fromJson));

  static Future updateTask(Task task) async {
    final docTask = FirebaseFirestore.instance.collection('task').doc(task.id);

    await docTask.update(task.toJson());
  }

  static Future deleteTask(Task task) async {
    final docTask = FirebaseFirestore.instance.collection('task').doc(task.id);

    await docTask.delete();
  }
}
