import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/todo_model.dart';
import '../../logic/bloc/todo_bloc.dart';
import '../../logic/bloc/todo_event.dart';
import '../../logic/bloc/todo_state.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    log("Main build method Rebuild");
    return Scaffold(
      appBar: AppBar(title: const Text('Optimized Todo App')),
      body: Column(
        children: [
          const _FilterButtons(),
          const Expanded(child: _TodoList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final id = const Uuid().v4();
          context.read<TodoBloc>().add(
            AddTodo(Todo(id: id, title: 'Task $id', isCompleted: false)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TodoList extends StatelessWidget {
  const _TodoList();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TodoBloc, TodoState, List<Todo>>(
      selector: (state) => state.filteredTodos,
      builder: (context, todos) {
        log("ToDo List build method Rebuild");
        if (todos.isEmpty) return const Center(child: Text('No Todos'));
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, i) {
            final todo = todos[i];
            return ListTile(
              title: Text(todo.title),
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) =>
                    context.read<TodoBloc>().add(ToggleTodo(todo.id)),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () =>
                    context.read<TodoBloc>().add(DeleteTodo(todo.id)),
              ),
            );
          },
        );
      },
    );
  }
}

class _FilterButtons extends StatelessWidget {
  const _FilterButtons();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TodoBloc, TodoState, TodoFilter>(
      selector: (state) => state.filter,
      builder: (context, filter) {
        log("Filter List build method Rebuild");
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: TodoFilter.values.map((f) {
            final isActive = f == filter;
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ChoiceChip(
                label: Text(f.name),
                selected: isActive,
                onSelected: (_) =>
                    context.read<TodoBloc>().add(FilterChanged(f)),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
