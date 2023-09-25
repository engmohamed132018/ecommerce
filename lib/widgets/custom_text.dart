import 'package:flutter/material.dart';

class CustomeText extends StatelessWidget {
  final double font;
  final String text;
  final FontWeight fontWeight;
  final Color color;

  const CustomeText(
      {super.key,
      required this.font,
      this.color = Colors.black,
      required this.text,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: font, fontWeight: fontWeight, color: color),
    );
  }
}
