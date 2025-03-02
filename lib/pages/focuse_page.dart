import 'package:flutter/material.dart';

class FocusePage extends StatefulWidget {
  const FocusePage({super.key});

  @override
  State<FocusePage> createState() => _FocusePageState();
}

class _FocusePageState extends State<FocusePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('lib/assets/index.jpg', width: 300)],
        ),
      ),
    );
  }
}
