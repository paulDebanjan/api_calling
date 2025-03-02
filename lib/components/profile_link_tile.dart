import 'package:flutter/material.dart';

class ProfileLinkTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function()? onTap;

  const ProfileLinkTile({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(iconData),
                SizedBox(width: 10),
                Text(text, style: TextStyle(fontSize: 19)),
              ],
            ),

            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
