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

  // show window for creating todo
  void createTodoWidget() async {
    var _Controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(
              controller: _Controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              MaterialButton(
                onPressed: () async {
                  await createTodo(_Controller.text, false, context);
                  _Controller.clear();
                  Navigator.pop(context);
                },
                child: Text('Create'),
              ),
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
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'), centerTitle: true),
      body: screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          createTodoWidget();
        },
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
