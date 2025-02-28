import 'dart:convert';

import 'package:api_calling/models/todo.dart';
import 'package:api_calling/pages/home_page.dart';
import 'package:api_calling/pages/login_page.dart';
import 'package:api_calling/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

final storage = FlutterSecureStorage();

Future<void> login(
  String username,
  String password,
  BuildContext context,
) async {
  final url = Uri.parse('https://dummyjson.com/users/login');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    // emilys1
    // emilyspass
    body: jsonEncode({'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // Extract refresh token
    final refreshToken = data['refreshToken'];
    // store refresh token
    await storage.write(key: 'refreshToken', value: refreshToken);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } else {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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
    );
  }
}

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

Future<void> featchUserInfo() async {
  final url = Uri.parse('https://dummyjson.com/user/me');
  final token = await storage.read(key: 'refreshToken');
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer ${token}'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final id = data['id'];
    final fullName = data['firstName'] + ' ' + data['lastName'];
    await storage.write(key: 'id', value: id.toString());
    await storage.write(key: 'userName', value: fullName);
    print(id);
    print(fullName);
  } else {
    print('response failed 1');
  }
}

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
    print(todos);
    await Provider.of<TaskProvider>(
      context,
      listen: false,
    ).set_todo_list(todos);
  } else {
    print('response failed 2');
  }
}
