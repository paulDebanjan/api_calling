import 'package:flutter/material.dart';

class ProfileLinkTitleText extends StatelessWidget {
  final String text;
  const ProfileLinkTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
      child: Text(text, style: TextStyle(fontSize: 14)),
    );
  }
}
