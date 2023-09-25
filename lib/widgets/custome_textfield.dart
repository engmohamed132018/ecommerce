import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomeTextField extends StatelessWidget {
  final Color borderColor;
  final Color labelColor;
  final String text;
  InputBorder? border;
  final String hintText;
  final bool isHide;
  final FormFieldValidator<String?>? validate;
  final ValueChanged? onSave;

  CustomeTextField(
      {super.key,
      required this.borderColor,
      required this.labelColor,
      required this.text,
      required this.hintText,
      this.isHide = false,
      this.validate,
      this.onSave,
      this.border});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: isHide,
        cursorColor: labelColor,
        validator: validate,
        onSaved: onSave,
        decoration: InputDecoration(
            hintText: hintText,
            labelStyle: TextStyle(color: labelColor),
            labelText: text,
            focusedBorder: border));
  }
}
