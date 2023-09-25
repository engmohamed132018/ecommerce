import 'package:ecommerce/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static final _auth = FirebaseAuth.instance;
  Future<String> loginByEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await sharedPreferences.setBool('login', false);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user!.uid.isEmpty) {
        return '';
      } else {
        await sharedPreferences.setBool('login', true);
        return '';
      }
    } catch (e) {
      return 'please enter correct email and password';
    }
  }

  static String getUserId() {
    return _auth.currentUser!.uid;
  }

  void registerByEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {}
  }

  void signOut() async {
    await _auth.signOut();
    sharedPreferences.remove('token');
  }
}
