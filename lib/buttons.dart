import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final color;
  // ignore: prefer_typing_uninitialized_variables
  final textColor;
  final double size;
  final String buttonText;
  // ignore: prefer_typing_uninitialized_variables
  final buttonTapped;

  // ignore: use_key_in_widget_constructors
  const MyButton(
      {this.color,
      this.textColor,
      required this.size,
      required this.buttonText,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            alignment: Alignment.center,
            color: color,
            child: Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: size),
            ),
          ),
        ),
      ),
    );
  }
}
