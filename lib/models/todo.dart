import 'dart:convert';

class Todo {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, todo: $todo, completed: $completed, userId: $userId)';
  }
}

List<Todo> parseTodos(String responseBody) {
  final parsed = jsonDecode(responseBody);
  if (parsed is List) {
    // If the API returns a list, convert each item
    return parsed.map<Todo>((json) => Todo.fromJson(json)).toList();
  } else if (parsed is Map<String, dynamic>) {
    // If the API returns a single object, wrap it in a list
    return [Todo.fromJson(parsed)];
  } else {
    return [];
  }
}
