import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomeSocialButton extends StatelessWidget {
  const CustomeSocialButton({
    super.key,
    required this.appFonts,
    required this.imgurl,
    this.onclicked,
    required this.text,
  });

  final double appFonts;
  final String imgurl;
  final VoidCallback? onclicked;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        )),
        onPressed: onclicked,
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(imgurl),
            ),
            SizedBox(
              width: 80,
            ),
            CustomeText(font: appFonts, text: text),
          ],
        ));
  }
}
