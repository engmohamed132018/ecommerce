import 'package:flutter/material.dart';

class AppFonts {
  final BuildContext context;
  AppFonts({required this.context});

  ///fonts for app
  ///
  double get font30 => MediaQuery.of(context).size.height * .034;

  double get font18 => MediaQuery.of(context).size.height * .020;

  double get font14 => MediaQuery.of(context).size.height * .015;

  double get font16 => MediaQuery.of(context).size.height * .018;

//// app color
  Color get greenColor => Color(0xff00C569);
}
