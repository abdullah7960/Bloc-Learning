import 'package:equatable/equatable.dart';
import 'package:learning_bloc/todo_app/logic/bloc/todo_event.dart';

import '../../data/models/todo_model.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final bool isLoading;
  final String? error;
  final TodoFilter filter;

  const TodoState({
    required this.todos,
    this.isLoading = false,
    this.error,
    this.filter = TodoFilter.all,
  });

  List<Todo> get filteredTodos {
    switch (filter) {
      case TodoFilter.active:
        return todos.where((item) => !item.isCompleted).toList();
      case TodoFilter.completed:
        return todos.where((item) => item.isCompleted).toList();
      default:
        return todos;
    }
  }

  TodoState copyWith({
    List<Todo>? todos,
    bool? isLoading,
    String? error,
    TodoFilter? filter,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [todos, isLoading, error, filter];
}
