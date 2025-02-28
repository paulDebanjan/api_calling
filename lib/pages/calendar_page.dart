import 'package:api_calling/login.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Calender'), centerTitle: true,leading: IconButton(
          onPressed: () => logout(context),
          icon: Icon(Icons.logout),
        ),));
  }
}