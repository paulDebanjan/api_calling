import 'package:api_calling/models/todo.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List<Todo> _todoList = [];

  // get
  List<Todo> get getTodoList => _todoList;

  // set list from api
  void intializeList(List<Todo> todo) {
    _todoList.clear();
    _todoList.addAll(todo);
    notifyListeners();
  }

  // set list from api
  void setTodoList(List<Todo> todo) {
    _todoList.addAll(todo);
    notifyListeners();
  }

  // update
  void updatCheckbox(int id, bool isComplete) {
    int index = _todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todoList[index] = _todoList[index].copyWith(completed: isComplete);
    }
    notifyListeners();
  }

  // delete
  void deleteTodoFromList(int id) {
    int index = _todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todoList.removeAt(index);
    }
    notifyListeners();
  }

  void updateMyTiles(int oldIndex, int newIndex) {
    // an adjustment is needed when moving the tile down the list
    if (oldIndex < newIndex) {
      newIndex--;
    }
    // get the tile we are moving
    final tile = _todoList.removeAt(oldIndex);
    // place the tile in the new position
    _todoList.insert(newIndex, tile);
    notifyListeners();
  }
}
