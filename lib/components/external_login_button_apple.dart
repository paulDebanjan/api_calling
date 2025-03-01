import 'package:flutter/material.dart';

class ExternalLoginButtonApple extends StatelessWidget {
  final Function()? onTap;
  final Image image;
  final String buttonName;
  const ExternalLoginButtonApple({
    super.key,
    required this.onTap,
    required this.buttonName,
    required this.image,
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(73, 255, 255, 255),
            ),
            child: image,
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
