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

  // delete option click
  void deleteTodoItem(int index) {
    deleteTodo(index, context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    List<Todo> todoList = provider.getTodoList;
    print('todolist Lenght: ${todoList.length}');
    return Container(
      padding: const EdgeInsets.only(right: 25, left: 25),
      child: ReorderableListView(
        buildDefaultDragHandles: false,
        onReorder: provider.updateMyTiles,
        children: [
          for (int i = 0; i < todoList.length; i++)
            ReorderableDragStartListener(
              // Enables dragging from anywhere
              key: ValueKey('${todoList[i].id}_$i'),
              index: i,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Card(
                  // Card makes dragging look smoother
                  color: Theme.of(context).colorScheme.secondary,
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: todoList[i].completed,
                                onChanged:
                                    (value) => {
                                      updateCheckBox(value, todoList[i].id),
                                    },
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
                          IconButton(
                            onPressed: () => deleteTodoItem(todoList[i].id),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
