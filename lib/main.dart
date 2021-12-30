import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/login/front_page.dart';
import 'package:task/login/signinwithgoogle.dart';
import 'package:task/task.dart';

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
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => GoogleSigninProvider())
        ],
        child: MaterialApp(
          title: "Task",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.deepPurpleAccent[100]),
          home: FrontPage(),
        ),
      ));
}
