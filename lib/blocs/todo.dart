import 'package:rxdart/rxdart.dart';
import 'package:com.byronferguson.todo_flutter/models/todo.dart';

enum kTodoVisibility { SHOW_ALL, SHOW_COMPLETED, SHOW_ACTIVE }

class TodoBloc {
  final _filter = BehaviorSubject<kTodoVisibility>.seeded(kTodoVisibility.SHOW_ALL);
  final _todos = BehaviorSubject<List<Todo>>.seeded([]);
  final _addTodo = PublishSubject<Todo>();
  final _toggleTodo = PublishSubject<Todo>();
  final _newTodo = BehaviorSubject<String>();

  // GETTERS
  Stream<List<Todo>> get todos => _todos.stream;
  Stream<kTodoVisibility> get filter => _filter.stream;
  Stream<String> get newTodo => _newTodo.stream;
  Stream<List<Todo>> get filteredTodos =>
      Observable.combineLatest2<kTodoVisibility, List<Todo>, List<Todo>>(
        filter,
        todos,
        (filter, todos) {
          switch (filter) {
            case kTodoVisibility.SHOW_ACTIVE:
              return todos.where((todo) => !todo.completed).toList();
            case kTodoVisibility.SHOW_COMPLETED:
              return todos.where((todo) => todo.completed).toList();
            case kTodoVisibility.SHOW_ALL:
            default:
              return todos;
          }
        },
      );

  // SETTERS
  Function(List<Todo>) get updateTodos => _todos.sink.add;
  Function(kTodoVisibility) get changeFilter => _filter.sink.add;
  Function(String) get changeNewTodo => _newTodo.sink.add;

  // Public
  void addTodo() {
    final todo = Todo(
      (b) => b
        ..text = _newTodo.value
        ..completed = false,
    );

    _addTodo.sink.add(todo);
  }

  void toggleTodo(Todo target) {
    final todos = _todos.value
        .map(
          (todo) => todo != target ? todo : todo.rebuild((t) => t.completed = !t.completed),
        )
        .toList();

    updateTodos(todos);
  }

  // Private
  TodoBloc() {
    _addTodo.map<List<Todo>>((todo) => [..._todos.value, todo]).listen(updateTodos);
  }

  dispose() {
    _todos.close();
    _addTodo.close();
    _toggleTodo.close();
    _newTodo.close();
    _filter.close();
  }
}
