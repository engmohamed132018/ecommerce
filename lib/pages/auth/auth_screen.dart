// ignore_for_file: must_be_immutable

import 'package:ecommerce/main.dart';
import 'package:ecommerce/main_nav_bar.dart';
import 'package:ecommerce/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoding = false;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getBool();
  }

  Widget getBool() {
    isLoding = sharedPreferences.getBool('login') ?? false;
    return isLoding ? MainBar() : LoginScreen();
  }
}
