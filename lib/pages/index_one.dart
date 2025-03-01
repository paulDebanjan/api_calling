import 'package:api_calling/api_work.dart';
import 'package:api_calling/models/todo.dart';
import 'package:api_calling/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexOne extends StatefulWidget {
  const IndexOne({super.key});

  @override
  State<IndexOne> createState() => _IndexOneState();
}

// update checkbox value
class _IndexOneState extends State<IndexOne> {
  void updateCheckBox(bool? value, int id) {
    // print('id: $id and value $value');
    isCompleteButtonUpdate(id, value ?? false, context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    List<Todo> todoList = provider.getTodoList;
    print('todolist Lenght: ${todoList.length}');
    return ReorderableListView(
      buildDefaultDragHandles: false,
      onReorder: provider.updateMyTiles,
      children: [
        for (int i = 0; i < todoList.length; i++)
          ReorderableDragStartListener(
            // Enables dragging from anywhere
            key: ValueKey('${todoList[i].id}_$i'),
            index: i,
            child: Card(
              // Card makes dragging look smoother
              color: const Color.fromARGB(255, 228, 108, 108),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                title: Row(
                  children: [
                    Checkbox(
                      value: todoList[i].completed,
                      onChanged:
                          (value) => {updateCheckBox(value, todoList[i].id)},
                    ),
                    Text(
                      todoList[i].todo,
                      style: TextStyle(
                        decoration:
                            todoList[i].completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
      ],
    );
  }
}
