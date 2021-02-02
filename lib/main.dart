import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:task/task.dart';
import 'homepage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
          title: "Task",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.deepPurpleAccent[100]),
          home: ShowCaseWidget(
              builder: Builder(
            builder: (_) => Homepage(),
          ))));
}
