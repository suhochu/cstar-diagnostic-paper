import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  final String text;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        backgroundColor: Colors.redAccent,
      ),
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
