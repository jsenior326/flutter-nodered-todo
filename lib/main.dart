import 'package:flutter/material.dart';
import 'todo_list_screen.dart';

// Entry point to the application
void main() {
  runApp(MyApp());
}

// The main app widget. Essentially the root of our widget tree.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        title: "To-Do List",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoListScreen(), // Home screen of our app
      ),
    );
  }
}