import 'package:learning_bloc/todo_app/data/models/todo_model.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  Future<List<Todo>> fetchTodo() async {
    await Future.delayed(const Duration(microseconds: 500));
    return List.unmodifiable(_todos);
  }

  Future<void> addTodo(Todo todo) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _todos.add(todo);
  }

  Future<void> deleteTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _todos.removeWhere((item) => item.id == id);
  }

  Future<void> toogleTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _todos.indexWhere((item) => item.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
    }
  }
}
