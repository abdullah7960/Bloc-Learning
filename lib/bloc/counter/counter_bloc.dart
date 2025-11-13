import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/bloc/counter/counter_event.dart';
import 'package:learning_bloc/bloc/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(count: 0)) {
    on<IncrementEvent>(_incremnet);
    on<DecrementEvent>(_decrement);
    on<ResetEvent>(_reset);
  }

  void _incremnet(IncrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(count: state.count + 1));
  }

  void _decrement(DecrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(count: state.count - 1));
  }

  void _reset(ResetEvent event, Emitter<CounterState> emit) {
    emit(CounterState(count: 0));
  }
}
