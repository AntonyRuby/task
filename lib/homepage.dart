import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/cloud.dart';
import 'package:task/tasklist.dart';
import 'package:task/tasks.dart';
import 'addtasks.dart';
import 'completedlist.dart';
import 'task.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

ThemeData lighttheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,
  accentColor: Colors.deepPurpleAccent[100],
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.deepPurple,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.purple),
    bodyText2: TextStyle(color: Colors.black),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.deepPurpleAccent[100],
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
  ),
);

class _HomepageState extends State<Homepage> {
  bool light = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Tasklist(),
      Completedlist(),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: light ? lighttheme : darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Task",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          actions: [
            Switch(
                value: light,
                onChanged: (value) {
                  setState(() {
                    light = value;
                  });
                })
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          currentIndex: selectedIndex,
          onTap: (index) => setState(() {
            selectedIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.fact_check_sharp), label: "Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_outlined), label: "Completed"),
          ],
        ),
        body: StreamBuilder<List<Task>>(
            stream: Saveto.readTask(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Please Try Later');
                  } else {
                    final task = snapshot.data;
                    final provider = Provider.of<TaskProvider>(context);
                    provider.setTask(task);

                    return tabs[selectedIndex];
                  }
              }
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
              context: context, child: AddTasks(), barrierDismissible: false),
        ),
      ),
    );
  }
}
