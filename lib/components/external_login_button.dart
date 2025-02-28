import 'package:flutter/material.dart';

class ExternalLoginButton extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String buttonName;
  const ExternalLoginButton({
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
        border: Border.all(color: Colors.lightBlue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Image.asset(imagePath, width: 15),
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
