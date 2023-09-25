import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton(
      {super.key,
      required this.appFonts,
      required this.text,
      this.size = const Size(double.infinity, 50),
      this.onClicked});

  final double appFonts;
  final Size size;
  final String text;
  final VoidCallback? onClicked;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff00C569),
        minimumSize: size,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      onPressed: onClicked,
      child: CustomeText(font: appFonts, text: text, color: Colors.white),
    );
  }
}
