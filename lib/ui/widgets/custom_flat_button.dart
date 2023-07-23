import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;
  final OutlinedBorder shape; // Add this line

  CustomFlatButton({
    required this.title,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
    required this.onPressed,
    required this.color,
    required this.splashColor,
    required this.borderColor,
    required this.borderWidth,
    required this.shape, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            decoration: TextDecoration.none,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "OpenSans",
          ),
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(shape), // Set the shape here
        backgroundColor: MaterialStateProperty.all(color),
        overlayColor: MaterialStateProperty.all(splashColor),
        side: MaterialStateProperty.all(
          BorderSide(color: borderColor, width: borderWidth),
        ),
      ),
    );
  }
}
