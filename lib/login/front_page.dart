import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/homepage.dart';
import 'package:task/login/signinwithgoogle.dart';
import 'package:task/login/signup.dart';
import '../authentication.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class FrontPage extends StatefulWidget {
  static const routeName = '/signin';
  // showpassword = '';
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  // navigateToLogin() async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => Homepage()));
  // }

  // navigateToSignUp() async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => Homepage()));
  // }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formkey = GlobalKey();

  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  Map<String, String> authdata = {'email': '', 'password': ''};

  String email, password;

  void showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Okay"))
              ],
            ));
  }

  Future<void> signin() async {
    if (!formkey.currentState.validate()) {
      return;
    }
    formkey.currentState.save();
    try {
      await Provider.of<Authentication>(context, listen: false)
          .signin(authdata['email'], authdata['password']);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Homepage()));
      Navigator.of(context).pushReplacementNamed(Homepage.routeName);
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again.';
      showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Form(
          key: formkey,
          child: Column(
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

              //Email
              Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains("@")) {
                          return "Invalid email";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        authdata['email'] = value;
                      })),
              //Password
              Spacer(),
              Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        // suffixIcon: GestureDetector(
                        //   onTap: (){
                        //     // setState(() {
                        //     //   showpassword = !showpassword;
                        //     // });
                        //   },
                        //   // child: Icon(showpassword ? Icons.visibility : Icons.visibility_off),
                        // )
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length <= 5) {
                          return "Invalid password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        authdata['password'] = value;
                      })),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 90,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Theme.of(context).primaryColor,
                        child: InkWell(
                            onTap: () {
                              signin();
                            },
                            child: Center(
                                child: Text(
                              "SignIn",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ))),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 50,
                      width: 90,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Center(
                                child: Text(
                              "SignUp",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSigninProvider>(context, listen: false);
                  provider.login();
                },
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
