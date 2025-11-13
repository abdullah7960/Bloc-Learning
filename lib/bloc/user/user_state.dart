import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final String name;
  final int age;

  const UserState({required this.name, required this.age});

  // A copyWith method to update values easily
  UserState copyWith({String? name, int? age}) {
    return UserState(name: name ?? this.name, age: age ?? this.age);
  }

  @override
  List<Object> get props => [name, age];
}
