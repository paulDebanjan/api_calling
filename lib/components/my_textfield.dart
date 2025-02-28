import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String fieldName;
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextfield({
    super.key,
    required this.fieldName,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username', style: TextStyle(color: Colors.white)),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.grey.shade100),
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
