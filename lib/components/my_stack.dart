import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(thickness: 1, color: Colors.grey, height: 20),
        Container(
          color: Colors.grey.shade900,
          child: Text('OR', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
