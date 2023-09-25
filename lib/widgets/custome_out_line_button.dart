// ignore_for_file: must_be_immutable

import 'package:ecommerce/utilits/fonts.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomOutLineButton extends StatelessWidget {
  CustomOutLineButton({super.key, required this.onClicked});

  AppFonts? appFonts;
  final VoidCallback onClicked;
  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(150, 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.green)),
      ),
      onPressed: onClicked,
      child: CustomeText(font: appFonts!.font16, text: 'Back'),
    );
  }
}
