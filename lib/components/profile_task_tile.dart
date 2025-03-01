import 'package:flutter/material.dart';

class ProfileTaskTile extends StatelessWidget {
  String text;
  ProfileTaskTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(text),
    );
  }
}
