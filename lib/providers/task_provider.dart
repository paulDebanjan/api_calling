import 'package:api_calling/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskProvider extends ChangeNotifier {
  List<Todo> _todo_list = [];

  List<Todo> get get_todo_list => _todo_list;

  void set_todo_list(List<Todo> todo) {
    _todo_list.addAll(todo);
    print('taskProvider: $_todo_list');
    notifyListeners();
  }

  void updatCheckbox(int id, bool isComplete) {
    int index = _todo_list.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todo_list[index] = _todo_list[index].copyWith(completed: isComplete);
    }
    notifyListeners();
  }
  void deleteTodoFromList(int id) {
    int index = _todo_list.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todo_list.removeAt(index);
    }
    notifyListeners();
  }
  void reorderTodos(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex--;
    }
    final item = _todo_list.removeAt(oldIndex);
    _todo_list.insert(newIndex, item);
    notifyListeners();
  }
}
