import 'package:api_calling/api_work.dart';
import 'package:api_calling/models/todo.dart';
import 'package:api_calling/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

// update checkbox value
class _IndexPageState extends State<IndexPage> {
  void updateCheckBox(bool? value, int id) {
    isCompleteButtonUpdate(id, value ?? false, context);
  }

  // delete option click
  void deleteTodoItem(int index) {
    deleteTodo(index, context);
  }

  @override
  void dispose() {
    _searchController.dispose(); // Prevent memory leaks
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    List<Todo> todoList = provider.getTodoList;

    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10, top: 30),
      child: Column(
        children: [
          // search
          Container(
            padding: const EdgeInsets.only(
              top: 12,
              left: 22,
              right: 22,
              bottom: 12,
            ),

            child: TextField(
              onChanged: provider.searchTodo,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                hintText: 'Search',
                fillColor: Theme.of(context).colorScheme.inversePrimary,
                filled: true,
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                todoList.isNotEmpty
                    ? Container(
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                        top: 25,
                      ),
                      child: ReorderableListView(
                        buildDefaultDragHandles: false,
                        onReorder: provider.updateMyTiles,
                        children: [
                          for (int i = 0; i < todoList.length; i++)
                            ReorderableDelayedDragStartListener(
                              // Enables dragging from anywhere
                              key: ValueKey('${todoList[i].id}_$i'),
                              index: i,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed:
                                            (context) =>
                                                deleteTodoItem(todoList[i].id),
                                        icon: Icons.delete,
                                        backgroundColor: Colors.red.shade300,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    // Card makes dragging look smoother
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    elevation: 2,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 8,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Checkbox(
                                              shape: CircleBorder(),
                                              value: todoList[i].completed,
                                              onChanged:
                                                  (value) => {
                                                    updateCheckBox(
                                                      value,
                                                      todoList[i].id,
                                                    ),
                                                  },
                                            ),
                                            Text(
                                              todoList[i].todo,
                                              style: TextStyle(
                                                decoration:
                                                    todoList[i].completed
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
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
                            Text(
                              'Tap + add your tasks',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
