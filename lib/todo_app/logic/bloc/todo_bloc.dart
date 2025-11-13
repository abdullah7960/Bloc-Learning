import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc(this._repository) : super(const TodoState(todos: [])) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleTodo>(_onToggleTodo);
    on<FilterChanged>(_onFilterChanged);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final todos = await _repository.fetchTodos();
      emit(state.copyWith(todos: todos, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    await _repository.addTodo(event.todo);
    add(LoadTodos()); // refresh list
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    await _repository.deleteTodo(event.id);
    add(LoadTodos());
  }

  Future<void> _onToggleTodo(ToggleTodo event, Emitter<TodoState> emit) async {
    await _repository.toggleTodo(event.id);
    add(LoadTodos());
  }

  Future<void> _onFilterChanged(
    FilterChanged event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(filter: event.filter));
  }
}
