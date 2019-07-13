import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.byronferguson.todo_flutter/blocs/todo.dart';
import 'package:com.byronferguson.todo_flutter/models/todo.dart';

import 'package:com.byronferguson.todo_flutter/widgets/loading.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoBloc = Provider.of<TodoBloc>(context);

    return StreamBuilder<List<Todo>>(
      stream: todoBloc.filteredTodos,
      initialData: [],
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();

        final todos = snapshot.data;

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) => TodoListItem(
            todo: todos[index],
            onChanged: (_) => todoBloc.toggleTodo(todos[index]),
            key: Key(todos[index].hashCode.toString()),
          ),
        );
      },
    );
  }
}

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final Function(bool) onChanged;

  TodoListItem({
    @required this.todo,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: todo.completed,
      onChanged: onChanged,
      title: Text(todo.text),
    );
  }
}
