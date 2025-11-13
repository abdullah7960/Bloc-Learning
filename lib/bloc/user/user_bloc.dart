// --- BLOC ---
import 'package:bloc/bloc.dart';
import 'package:learning_bloc/bloc/user/user_state.dart';

import 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState(name: "Abdullah", age: 25)) {
    on<UpdateName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<UpdateAge>((event, emit) {
      emit(state.copyWith(age: event.age));
    });
  }
}
