// profile smaill text

// matching is valid or not
import 'package:api_calling/models/todo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

bool isIdInTodoList(int id, List<Todo> todos) {
  return todos.any((todo) => todo.id == id);
}

// checking internet connection
Future<bool> isInternetAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

void showDialogGivingAlert(String text, BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content: Text(text),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            ),
          ],
        ),
  );
}
