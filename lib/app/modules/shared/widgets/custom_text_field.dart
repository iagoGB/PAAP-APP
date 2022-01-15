import 'package:flutter/material.dart';

Widget CustomTextFormField({
  required String label,
  required Color labelColor,
  required TextInputType inputType,
  required dynamic validator,
  required dynamic controller,
  int maxLines = 1,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: TextFormField(
      validator: (val) => validator(val),
      controller: controller,
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: 1,
      maxLines: maxLines,
      decoration: decorationStyle(label: label, labelColor: labelColor),
    ),
  );
}

InputDecoration decorationStyle({
  required String label,
  required Color labelColor,
}) {
  return InputDecoration(
    label: Text(label),
    labelStyle: TextStyle(fontSize: 22),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    floatingLabelStyle: TextStyle(color: labelColor, fontSize: 22),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: labelColor, width: 1),
    ),
    errorBorder: null,
  );
}
