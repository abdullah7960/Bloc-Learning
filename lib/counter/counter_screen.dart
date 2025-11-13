import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/counter/cubit.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("build method call");
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App", style: TextStyle(fontSize: 20)),
      ),
      body: Column(
        children: [
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) {
              return Center(
                child: Text(state.toString(), style: TextStyle(fontSize: 40)),
              );
            },
          ),
          Text(
            "${context.watch<CounterCubit>().state}",
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        onPressed: () {
          context.read<CounterCubit>().increment();
        },
      ),
    );
  }
}
