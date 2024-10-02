import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profit_event.dart';
part 'profit_state.dart';

class ProfitBloc extends Bloc<ProfitEvent, ProfitState> {
  
  ProfitBloc(): super(const ProfitState(initAmount: 00, finalAmount: 0.0)) {
    on<ProfitUpdated>(_onProfitCalculate);
  }

  void _onProfitCalculate(ProfitUpdated event, Emitter<ProfitState> emit) {
    emit(
      state.copyWith(
        initAmount: state.initAmount + 1,
        finalAmount: state.finalAmount + 1,
      )
    );
  }

  void increaseBy([double value = 1.0]) {
    add(ProfitUpdated(value));
  }
}
