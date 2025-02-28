import 'package:api_calling/login.dart';
import 'package:flutter/material.dart';

class FocusePage extends StatefulWidget {
  const FocusePage({super.key});

  @override
  State<FocusePage> createState() => _FocusePageState();
}

class _FocusePageState extends State<FocusePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Focus'));
  }
}
