import 'package:equatable/equatable.dart';
import 'package:learning_bloc/todo_app/data/models/todo_model.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;
  const AddTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final String id;
  const DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTodo extends TodoEvent {
  final String id;
  const ToggleTodo(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterChanged extends TodoEvent {
  final TodoFilter filter;
  const FilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

enum TodoFilter { all, active, completed }
