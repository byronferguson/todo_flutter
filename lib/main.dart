import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.byronferguson.todo_flutter/blocs/todo.dart';

import 'package:com.byronferguson.todo_flutter/screens/todos_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final todoBloc = TodoBloc();

  @override
  Widget build(BuildContext context) {
    return Provider<TodoBloc>.value(
      value: todoBloc,
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodosScreen(),
      ),
    );
  }
}
