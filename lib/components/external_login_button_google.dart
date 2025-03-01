import 'package:flutter/material.dart';

class ExternalLoginButtonGoogle extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String buttonName;
  const ExternalLoginButtonGoogle({
    super.key,
    required this.onTap,
    required this.buttonName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 106, 92, 196),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: Image.asset(imagePath, width: 16),
          ),
          Text(
            ' Login with $buttonName',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
