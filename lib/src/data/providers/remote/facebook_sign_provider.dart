import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignProvider extends ChangeNotifier {

  final _user = FacebookAuth.instance;
  get user => _user;


  Future signInWithFacebook() async {
    final LoginResult result = await _user.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    }
  }
  Future logout() async {
    _user.logOut();
  }
}
