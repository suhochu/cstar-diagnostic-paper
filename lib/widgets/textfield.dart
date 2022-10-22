import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.validator,
    this.keyboardType,
    this.maxLength = 20,
  }) : super(key: key);
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      autofocus: true,
      maxLength: maxLength,
      // showCursor: false,
      mouseCursor: SystemMouseCursors.click,
      style: const TextStyle(fontSize: 30, color: Colors.redAccent),
      maxLines: 1,
      decoration: textFieldInputDecoration(label: label, hint: hint),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}

InputDecoration textFieldInputDecoration({
  String? label,
  String? hint,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 20,
    ),
    hintText: hint,
    hintStyle: const TextStyle(
      color: Colors.blueGrey,
      fontSize: 20,
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(width: 1, color: Colors.blueAccent),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(width: 1, color: Colors.black45),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(width: 1, color: Colors.redAccent),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(width: 1, color: Colors.blueAccent),
    ),
  );
}

TextStyle textFieldTextStyle() {
  return const TextStyle(fontSize: 30, color: Colors.redAccent);
}
