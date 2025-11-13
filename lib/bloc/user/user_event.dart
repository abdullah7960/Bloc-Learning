// --- EVENTS ---
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateName extends UserEvent {
  final String name;
  const UpdateName(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdateAge extends UserEvent {
  final int age;
  const UpdateAge(this.age);

  @override
  List<Object?> get props => [age];
}
