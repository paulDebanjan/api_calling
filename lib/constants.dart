

// profile smaill text



  // matching is valid or not
  import 'package:api_calling/models/todo.dart';

bool isIdInTodoList(int id, List<Todo> todos) {
    return todos.any((todo) => todo.id == id);
  }