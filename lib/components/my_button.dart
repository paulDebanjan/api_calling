import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 140, 98, 255),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 140, 98, 255),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
