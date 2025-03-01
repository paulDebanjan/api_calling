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
  String appBarName = '';
  void changeAppBarName() {
    switch (_selectedIndex) {
      case 0:
        appBarName = 'Index';
        break;
      case 1:
        appBarName = 'Calender';
        break;
      case 2:
        appBarName = 'Focuse';
      case 3:
        appBarName = 'Profile';
        break;
      default:
        appBarName = 'Unknown Index';
    }
  }

  List<Widget> screens = [
    IndexPage(),
    CalendarPage(),
    FocusePage(),
    ProfilePage(),
  ];

  void _onItemPapped(index) {
    setState(() {
      _selectedIndex = index;
      changeAppBarName();
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
      _selectedIndex = 3;
      _isInitialized = true;
    });
  }

  @override
  void initState() {
    changeAppBarName();
    _initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(appBarName),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => logout(context),
          icon: Icon(Icons.logout),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage('lib/assets/man.jpg'),
            ),
          ),
        ],
      ),
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
