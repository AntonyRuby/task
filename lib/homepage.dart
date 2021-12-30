import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:task/src/models/cloud.dart';
import 'package:task/task/addtasks.dart';
import 'package:task/task/tasklist.dart';
import 'package:task/src/models/tasks.dart';

import 'login/signinwithgoogle.dart';
import 'task/completedlist.dart';
import 'task.dart';

class Homepage extends StatefulWidget {
  static const routeName = '/home';
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
    bodyText2: TextStyle(color: Colors.black),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  accentColor: Colors.deepPurpleAccent[100],
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.white),
  ),
);

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isloggedin = false;

  // AnimationController _controller;

  bool light = true;
  int selectedIndex = 0;
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();
  final keyFive = GlobalKey();
  final keySix = GlobalKey();

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 300),
    //   lowerBound: 0.0,
    //   upperBound: 0.1,
    // )
    // ..addListener(() {
    //     setState(() {});
    //   });

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase(
            [keyOne, keyTwo, keyThree, keyFour, keyFive, keySix]));
  }

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
            CustomShowcaseWidget(
              globalKey: keyOne,
              description: 'Light & Dark Theme Mode',
              child: Switch(
                  value: light,
                  onChanged: (value) {
                    setState(() {
                      light = value;
                    });
                  }),
            ),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSigninProvider>(context, listen: false);
                  provider.logout();
                })
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 90,
          child: BottomNavigationBar(
            elevation: 0,
            iconSize: 30,
            selectedFontSize: 16,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white60,
            currentIndex: selectedIndex,
            onTap: (index) => setState(() {
              selectedIndex = index;
            }),
            items: [
              BottomNavigationBarItem(
                  icon: CustomShowcaseWidget(
                      globalKey: keyTwo,
                      description: 'Incomplete Task',
                      child: Icon(Icons.fact_check_sharp)),
                  label: "Tasks"),
              BottomNavigationBarItem(
                  icon: CustomShowcaseWidget(
                      globalKey: keyThree,
                      description: 'Completed Task',
                      child: Icon(Icons.done_outlined)),
                  label: "Completed"),
            ],
          ),
        ),
        body: CustomShowcaseWidget(
            globalKey: keyFive,
            description: 'Swipe Right & Left to Edit & Delete Task ',
            child: StreamBuilder<List<Task>>(
                stream: Saveto.readTask(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Center(
                            child: Text(
                          'Please Try Later',
                          style: TextStyle(fontSize: 20),
                        ));
                      } else {
                        final task = snapshot.data;
                        final provider = Provider.of<TaskProvider>(context);
                        provider.setTask(task);

                        return tabs[selectedIndex];
                      }
                  }
                })),
        floatingActionButton: FloatingActionButton(
            child: CustomShowcaseWidget(
                globalKey: keyFour,
                description: 'Add New Task',
                child: Icon(Icons.add)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNewTask()));
            }),
      ),
    );
  }
}

class CustomShowcaseWidget extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;

  const CustomShowcaseWidget({
    @required this.child,
    @required this.description,
    @required this.globalKey,
  });

  @override
  Widget build(BuildContext context) => Showcase(
        key: globalKey,
        description: description,
        descTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        contentPadding: EdgeInsets.all(8),
        child: child,
      );
}
