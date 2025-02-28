import 'package:api_calling/components/todo_tile.dart';
import 'package:api_calling/login.dart';
import 'package:api_calling/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // check box was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {});
  }

  void deleteFunction(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    List todo_list = provider.get_todo_list;

    print('Home Page List: ${todo_list[0].id}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Index'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => logout(context),
          icon: Icon(Icons.logout),
        ),
      ),
      body:
          todo_list.length != 0
              ? ListView.builder(
                itemCount: todo_list.length,
                itemBuilder: (context, index) {
                  final todo_item = todo_list[index];
                  return TodoTile(
                    taskName: todo_item.todo,
                    taskCompleted: todo_item.completed,
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (value) => deleteFunction(index),
                  );
                },
              )
              : Container(),
    );
  }
}
