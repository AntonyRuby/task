import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:task/homepage.dart';
import 'package:task/login/signinwithgoogle.dart';

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Spacer(),
          Center(
              child: Container(
            child: Image.asset(
              'assets/Task.png',
              height: 150,
              width: 200,
            ),
          )),
          Spacer(),
          SignInButton(
            Buttons.Google,
            text: "Sign up with Google",
            onPressed: () async {
              final provider =
                  Provider.of<GoogleSigninProvider>(context, listen: false);
              await provider.login();
              if (provider.isSigningIn) {
                return buildLoading();
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowCaseWidget(
                            builder: Builder(builder: (_) => Homepage()))));
              }
            },
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget buildLoading() => Center(
        child: CircularProgressIndicator(),
      );
}
