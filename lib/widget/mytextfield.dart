import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry padding;

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue, width: 2.0), // Border when focused
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0), // Padding inside the text field
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }
}
