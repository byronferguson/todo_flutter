import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.byronferguson.todo_flutter/blocs/todo.dart';

import 'package:com.byronferguson.todo_flutter/widgets/new_todo.dart';
import 'package:com.byronferguson.todo_flutter/widgets/todo_list.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key key}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> with TickerProviderStateMixin {
  void _openNewTodo() {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
        builder: (context) => NewTodo(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _todoBloc = Provider.of<TodoBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Todo List'),
        bottom: TabBar(
          controller: TabController(
            length: 3,
            vsync: this,
          ),
          unselectedLabelColor: Theme.of(context).primaryColorLight,
          onTap: (index) {
            if (index == 0) {
              _todoBloc.changeFilter(kTodoVisibility.SHOW_ALL);
            } else if (index == 1) {
              _todoBloc.changeFilter(kTodoVisibility.SHOW_COMPLETED);
            } else {
              _todoBloc.changeFilter(kTodoVisibility.SHOW_ACTIVE);
            }
          },
          tabs: <Tab>[
            Tab(text: 'All'),
            Tab(text: 'Completed'),
            Tab(text: 'Active'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openNewTodo,
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
      body: TodoList(),
    );
  }
}
