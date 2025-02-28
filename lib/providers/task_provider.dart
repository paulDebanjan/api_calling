import 'package:api_calling/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskProvider extends ChangeNotifier {
  List<Todo> _todo_list = [];

  List<Todo> get get_todo_list => _todo_list;

  Future<void> set_todo_list(List<Todo> todo) async {
    _todo_list.addAll(todo);
    print('taskProvider: $_todo_list');
    notifyListeners();
  }
}
