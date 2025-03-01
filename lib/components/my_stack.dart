import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          thickness: 1,
          color: Theme.of(context).colorScheme.primary,
          height: 20,
        ),
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: Text(
            'OR',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
