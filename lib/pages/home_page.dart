import 'package:api_calling/api_work.dart';
import 'package:api_calling/pages/calendar_page.dart';
import 'package:api_calling/pages/focuse_page.dart';
import 'package:api_calling/pages/index_one.dart';
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
    // IndexPage(),
    IndexOne(),
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
            color:
                _selectedIndex == index
                    ? Colors.blue
                    : Theme.of(context).colorScheme.inversePrimary,
          ),
          Text(
            label,
            style: TextStyle(
              color:
                  _selectedIndex == index
                      ? Colors.blue
                      : Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
    );
  }

  // show window for creating todo
  void createTodoWidget() async {
    var _todoNameController = TextEditingController();
    var _todoDiscriptionController = TextEditingController();
    var _focusNode = FocusNode();

    showDialog(
      context: context,
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _focusNode.requestFocus(),
        );
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Task', style: TextStyle(fontSize: 19)),
                SizedBox(height: 4),
                TextField(
                  controller: _todoNameController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    hintText: 'Task',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _todoDiscriptionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    hintText: 'Description',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => _pickDateTime(context),
                      icon: Icon(Icons.timer),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (_todoNameController.text.isNotEmpty) {
                          await createTodo(
                            _todoNameController.text,
                            false,
                            context,
                          );
                          _todoNameController.clear();
                        }
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.send, color: Colors.lightBlue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _initializeApp() async {
    await Future.wait<void>([featchUserInfo(), initialReadUserTodo(context)]);
    setState(() {
      _selectedIndex = 0;
      _isInitialized = true;
    });
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  // Function to pick Date
  Future<void> _pickDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: "Select a Date", // 🔹 Change the header text
      confirmText: "Chose Time", // 🔹 Change "OK" button text
      cancelText: "CANCEL",
    );

    if (pickedDate != null) {
      // After selecting a date, show the time picker
      _pickTime(context, pickedDate);
    }
  }

  // Function to pick Time
  Future<void> _pickTime(BuildContext context, DateTime pickedDate) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          appBarName,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => logout(context),
          icon: Icon(Icons.logout),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('lib/assets/man.jpg'),
              ),
            ),
          ),
        ],
      ),
      body: screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 134, 135, 231),
        shape: CircleBorder(),
        onPressed: () {
          createTodoWidget();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
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
