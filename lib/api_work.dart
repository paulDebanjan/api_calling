import 'dart:convert';

import 'package:api_calling/models/todo.dart';
import 'package:api_calling/pages/home_page.dart';
import 'package:api_calling/pages/login_page.dart';
import 'package:api_calling/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

// instance of secureStorage
final storage = FlutterSecureStorage();

// login
Future<void> login(
  String username,
  String password,
  BuildContext context,
) async {
  final url = Uri.parse('https://dummyjson.com/users/login');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    // emilyspass
    body: jsonEncode({'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // Extract refresh token
    final refreshToken = data['refreshToken'];
    final id = data['id'];
    // store refresh token
    await storage.write(key: 'refreshToken', value: refreshToken);
    // store id
    await storage.write(key: 'id', value: id.toString());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } else {
    showDialog(
      context: context,
      builder:
          (context) => RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (event) {
              Navigator.pop(context);
            },
            child: AlertDialog(
              content: Text('Username or password is wrong'),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
            ),
          ),
    );
  }
}

// delete refresh token and logout
Future<void> logout(BuildContext context) async {
  await storage.delete(key: 'refreshToken');
  Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
}

Future<String?> readRefreshToken() async {
  final token = await storage.read(key: 'refreshToken');
  return token;
}

// fetch user info using refreshToken
Future<void> featchUserInfo() async {
  final url = Uri.parse('https://dummyjson.com/user/me');
  final token = await storage.read(key: 'refreshToken');
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer ${token}'},
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final fullName = data['firstName'] + ' ' + data['lastName'];
    await storage.write(key: 'userName', value: fullName);
  } else {
    print('response failed 1');
  }
}

// read todo list from api
Future<void> initialReadUserTodo(BuildContext context) async {
  final id = await storage.read(key: 'id');
  String data = 'https://dummyjson.com/todos/user/${id}';

  final url = Uri.parse(data);

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    List<dynamic> todoJsonList = responseData['todos'];
    // convert to todo model
    List<Todo> todos = todoJsonList.map((item) => Todo.fromJson(item)).toList();

    Provider.of<TaskProvider>(context, listen: false).intializeList(todos);
  } else {
    print('response failed 2');
  }
}

// read todo list from api
Future<void> readUserTodo(BuildContext context) async {
  final id = await storage.read(key: 'id');
  String data = 'https://dummyjson.com/todos/user/${id}';

  final url = Uri.parse(data);

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    List<dynamic> todoJsonList = responseData['todos'];
    // convert to todo model
    List<Todo> todos = todoJsonList.map((item) => Todo.fromJson(item)).toList();

    Provider.of<TaskProvider>(context, listen: false).setTodoList(todos);
  } else {
    print('response failed 2');
  }
}

// create a todo
Future<void> createTodo(
  String name,
  bool isCompleted,
  BuildContext context,
) async {
  final idString = await storage.read(key: 'id');
  final id = int.parse(idString.toString());
  final url = Uri.parse('https://dummyjson.com/todos/add');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'todo': name, 'completed': isCompleted, 'userId': id}),
  );

  if (response.statusCode == 201) {
    List<Todo> todos = parseTodos(response.body);
    try {
      Provider.of<TaskProvider>(context, listen: false).setTodoList(todos);
    } catch (e) {
      print('Error updating: $e');
    }
  } else {
    print('response failed 3');
  }
}

// update a todo
Future<void> isCompleteButtonUpdate(int id, bool isComplete, context) async {
  final url = Uri.parse('https://dummyjson.com/todos/${id}');

  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'completed': isComplete}),
  );
  print('UpdateMethod: ${response.statusCode}');

  // created todo not available in api server for that resion
  // 'if' condition will not work on local created todo
  // if (response.statusCode == 200) {
  Provider.of<TaskProvider>(
    context,
    listen: false,
  ).updatCheckbox(id, isComplete);
  // }
}

// delete a todo
Future<void> deleteTodo(int id, context) async {
  final url = Uri.parse('https://dummyjson.com/todos/${id}');
  // int idInt = int.parse(id);
  final response = await http.delete(url);
  // if (response.statusCode == 200) {
  Provider.of<TaskProvider>(context, listen: false).deleteTodoFromList(id);
  // }
}
