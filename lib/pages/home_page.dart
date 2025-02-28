import 'package:api_calling/login.dart';
import 'package:api_calling/pages/calendar_page.dart';
import 'package:api_calling/pages/focuse_page.dart';
import 'package:api_calling/pages/index_page.dart';
import 'package:api_calling/pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInitialized = false;
  int _selectedIndex = 0;

  List<Widget> screens = [
    IndexPage(),
    CalendarPage(),
    FocusePage(),
    ProfilePage(),
  ];

  void _onItemPapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildNavBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemPapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.blue : Colors.black,
          ),
          Text(label),
        ],
      ),
    );
  }

  Future<void> _initializeApp() async {
    await Future.wait<void>([featchUserInfo(), readUserTodo(context)]);
    setState(() {
      _selectedIndex = 0;
      _isInitialized = true;
    });
  }

  @override
  void initState() {
    _initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavBarItem(Icons.home, 'Index', 0),
            buildNavBarItem(Icons.calendar_month, 'Calender', 1),
            SizedBox(width: 20),
            buildNavBarItem(Icons.timelapse, 'Focus', 2),
            buildNavBarItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }
}
