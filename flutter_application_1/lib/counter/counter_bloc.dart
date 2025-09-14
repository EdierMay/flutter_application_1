import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<CounterIncremented>((event, emit) {
      final newValue = state.value + 1;
      emit(state.copyWith(value: newValue, status: _statusFromValue(newValue)));
    });

    on<CounterDecremented>((event, emit) {
      final newValue = state.value - 1;
      emit(state.copyWith(value: newValue, status: _statusFromValue(newValue)));
    });

    on<CounterReset>((event, emit) {
      emit(CounterState.initial());
    });
  }

  CounterStatus _statusFromValue(int v) {
    if (v == 0) return CounterStatus.initial;
    return v > 0 ? CounterStatus.positive : CounterStatus.negative;
  }
}
