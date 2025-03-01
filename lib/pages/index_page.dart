import 'package:api_calling/components/todo_tile.dart';
import 'package:api_calling/api_work.dart';
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
  void checkBoxChanged(bool? value, int id) {
    // print('id: $id and value $value');
    isCompleteButtonUpdate(id, value ?? false, context);
  }

  // delete option click
  // void deleteFunction(String index) {
  //   deleteTodo(index, context);
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    List todoList = provider.getTodoList;

    return todoList.isNotEmpty
        ? ListView.builder(
          padding: const EdgeInsets.only(bottom: 30),
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final todoItem = todoList[index];
            return TodoTile(
              taskName: todoItem.todo,
              taskCompleted: todoItem.completed,
              onChanged:
                  (value) =>
                      checkBoxChanged(value, int.parse(todoItem.id.toString())),
              // deleteFunction: (value) => deleteFunction(todoItem.id.toString()),
              deleteFunction: (value) => () {},
            );
          },
        )
        : Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/index.jpg', width: 300),
                Text(
                  'What do you want to do today?',
                  style: TextStyle(fontSize: 20),
                ),
                Text('Tap + add your tasks', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        );
  }
}
