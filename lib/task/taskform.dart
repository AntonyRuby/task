import 'package:flutter/material.dart';

class Taskform extends StatelessWidget {
  final String title;
  final String summary;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedSummary;
  final onSave;

  const Taskform({
    Key key,
    this.title = '',
    this.summary = '',
    @required this.onChangedTitle,
    @required this.onChangedSummary,
    @required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: title,
              maxLines: 2,
              onChanged: onChangedTitle,
              validator: (title) {
                if (title.isEmpty) {
                  return "Fill Title";
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: summary,
              maxLines: 3,
              onChanged: onChangedSummary,
              validator: (summary) {
                if (summary.isEmpty) {
                  return "Fill Task";
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Task',

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      
                    },
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            MaterialButton(
                onPressed: onSave,
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      );
}
