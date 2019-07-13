import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com.byronferguson.todo_flutter/blocs/todo.dart';

class NewTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _todoBloc = Provider.of<TodoBloc>(context);

    void submitNewTodo() {
      _todoBloc.addTodo();
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('New Todo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<String>(
              stream: _todoBloc.newTodo,
              builder: (context, snapshot) {
                return TextField(
                  autofocus: true,
                  onChanged: _todoBloc.changeNewTodo,
                  onSubmitted: (_) => submitNewTodo(),
                );
              },
            ),
            const SizedBox(height: 16.0),
            RaisedButton(
              onPressed: submitNewTodo,
              child: Text('Add Todo', style: TextStyle(color: Colors.white)),
              color: Theme.of(context).primaryColorDark,
            ),
          ],
        ),
      ),
    );
  }
}
