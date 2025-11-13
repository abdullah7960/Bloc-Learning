import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'counter/cubit.dart';
import 'todo_app/data/repositories/todo_repository.dart';
import 'todo_app/logic/bloc/todo_bloc.dart';
import 'todo_app/logic/bloc/todo_event.dart';
import 'todo_app/presentation/screens/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => TodoRepository())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CounterCubit()),
          BlocProvider(create: (_) => CounterBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(
            create: (context) =>
                TodoBloc(context.read<TodoRepository>())..add(LoadTodos()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const TodoPage(),
        ),
      ),
    );
  }
}
