import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication.dart';
import '../homepage.dart';

class Signup extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController passwordController = new TextEditingController();
  Map<String, String> authdata = {'email': '', 'password': ''};

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

  Future<void> signup() async {
    if (!formkey.currentState.validate()) {
      return;
    }
    formkey.currentState.save();
    try {
      await Provider.of<Authentication>(context, listen: false)
          .signup(authdata['email'], authdata['password']);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Homepage()));
      Navigator.of(context).pushReplacementNamed(Homepage.routeName);
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again.';
      showErrorDialog(errorMessage);
    }
  }

  bool _obscureText = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 0, 0),
              child: Text("Task",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 20),
            //Email
            Padding(
                padding: const EdgeInsets.fromLTRB(32, 20, 32, 20),
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
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
            Padding(
                padding: const EdgeInsets.fromLTRB(32, 20, 32, 10),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordStatus,
                        color: Colors.pink[400],
                      ),
                    ),
                    controller: passwordController,
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
            //Confirm Password
            Padding(
                padding: const EdgeInsets.fromLTRB(32, 20, 32, 10),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordStatus,
                        color: Colors.pink[400],
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value != passwordController.text) {
                        return "Invalid password";
                      }
                      return null;
                    },
                    onSaved: (value) {})),
            SizedBox(height: 40),
            Container(
                height: 60,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple,
                    child: InkWell(
                        onTap: () {
                          signup();
                        },
                        child: Center(
                            child: Text(
                          "SignUp",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ))),
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Go Back",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
