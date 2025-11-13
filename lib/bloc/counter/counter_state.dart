import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int count;
  final bool isEven;
  const CounterState({required this.count}) : isEven = count % 2 == 0;

  @override
  // TODO: implement props
  List<Object?> get props => [count, isEven];
}
