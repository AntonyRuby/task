import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task/src/models/user.dart';

class GoogleSigninProvider extends ChangeNotifier {
  final googlesignin = GoogleSignIn();
  bool _isSigningIn = false;

  GoogleSigninProvider() {
    isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final _user = await googlesignin.signIn();
    if (_user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await _user.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      user = AppUser(userId: googlesignin.currentUser.email);
      isSigningIn = false;
    }
  }

  void logout() async {
    await googlesignin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
