import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/bloc/counter/counter_bloc.dart';
import 'package:learning_bloc/bloc/counter/counter_state.dart';

import 'counter_event.dart';

class CounterScreenWithBloc extends StatefulWidget {
  const CounterScreenWithBloc({super.key});

  @override
  State<CounterScreenWithBloc> createState() => _CounterScreenWithBlocState();
}

class _CounterScreenWithBlocState extends State<CounterScreenWithBloc> {
  @override
  Widget build(BuildContext context) {
    log("🔁 build() called");
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Magic Counter')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -------------------- BlocBuilder --------------------
          const Text("BlocBuilder (Rebuilds on every state change)"),
          BlocBuilder<CounterBloc, CounterState>(
            buildWhen: (previous, current) => previous.count == 17,
            builder: (context, state) {
              log("🎨 BlocBuilder Rebuild");
              return Text(
                'Count: ${state.count}',
                style: TextStyle(fontSize: 40),
              );
            },
          ),
          const SizedBox(height: 30),

          // -------------------- BlocConsumer --------------------
          const Text(
            "BlocConsumer (Build + Listen together)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          BlocConsumer<CounterBloc, CounterState>(
            // buildWhen: (previous, current) => current.count == 9,
            builder: (context, state) {
              log("🧩 BlocConsumer Rebuild");
              return Text(
                "Value: ${state.count}",
                style: const TextStyle(fontSize: 30),
              );
            },
            listenWhen: (previous, current) => current.count == 10,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("🔥 You reached 10!")),
              );
            },
          ),
          const SizedBox(height: 30),

          // -------------------- BlocSelector --------------------
          const Text(
            "BlocSelector (Rebuilds only if isEven changes)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          BlocSelector<CounterBloc, CounterState, bool>(
            selector: (state) => state.isEven,
            builder: (context, isEven) {
              return Text(
                isEven ? "Even Number" : "Odd Number",
                style: const TextStyle(fontSize: 30),
              );
            },
          ),

          const SizedBox(height: 40),
          // -------------------- Buttons --------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () =>
                    context.read<CounterBloc>().add(DecrementEvent()),
                heroTag: "dec",
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                onPressed: () =>
                    context.read<CounterBloc>().add(IncrementEvent()),
                heroTag: "inc",
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                onPressed: () => context.read<CounterBloc>().add(ResetEvent()),
                heroTag: "reset",
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
