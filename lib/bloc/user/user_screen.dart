import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("🔄 UserScreen build called");

    return Scaffold(
      appBar: AppBar(title: const Text("Bloc Example - Selector vs Builder")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bloc Builder", style: const TextStyle(fontSize: 24)),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                log("Bloc Builder 👷 NAME widget rebuilt");
                return Text(
                  "Name: ${state.name}",
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            Text("Bloc Builder", style: const TextStyle(fontSize: 24)),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                log("Bloc Builder 👷 AGE widget rebuilt");
                return Text(
                  "Age: ${state.age}",
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            Text("Bloc Selector", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            // =============================
            // BlocSelector for Name
            // =============================
            BlocSelector<UserBloc, UserState, String>(
              selector: (state) => state.name,
              builder: (context, name) {
                log("Selector 👷 NAME widget rebuilt");
                return Text(
                  "Name: $name",
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),

            const SizedBox(height: 16),

            // =============================
            // BlocSelector for Age
            // =============================
            BlocSelector<UserBloc, UserState, int>(
              selector: (state) => state.age,
              builder: (context, age) {
                log(" SElector AGe 👷 AGE widget rebuilt");
                return Text("Age: $age", style: const TextStyle(fontSize: 24));
              },
            ),

            const SizedBox(height: 30),

            // =============================
            // BlocListener for side effects
            // =============================
            // BlocListener<UserBloc, UserState>(
            //   listenWhen: (prev, curr) => prev.age != curr.age,
            //   listener: (context, state) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: Text("🎉 Age changed to ${state.age}")),
            //     );
            //   },
            //   child: const SizedBox.shrink(),
            // ),

            // =============================
            // Buttons
            // =============================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final newName = "Abdullah ${DateTime.now().second}";
                    context.read<UserBloc>().add(UpdateName(newName));
                  },
                  child: const Text("Change Name"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final newAge = context.read<UserBloc>().state.age + 1;
                    context.read<UserBloc>().add(UpdateAge(newAge));
                  },
                  child: const Text("Increase Age"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =============================
            // BlocConsumer Example
            // =============================
            // BlocConsumer<UserBloc, UserState>(
            //   listenWhen: (prev, curr) => prev.name != curr.name,
            //   listener: (context, state) {
            //     log("📢 Name changed: ${state.name}");
            //   },
            //   buildWhen: (prev, curr) => prev.name != curr.name,
            //   builder: (context, state) {
            //     log("🧱 Consumer rebuilt for NAME");
            //     return Text(
            //       "Consumer Name: ${state.name}",
            //       style: const TextStyle(fontSize: 20, color: Colors.blue),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
