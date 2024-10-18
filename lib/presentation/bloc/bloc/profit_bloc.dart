import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profit_event.dart';
part 'profit_state.dart';

class ProfitBloc extends Bloc<ProfitEvent, ProfitState> {
  
  ProfitBloc(): super(const ProfitState(position: 0)) {
    on<ProfitPosition>(_onProfitUpdatePosition);
  }

  void _onProfitUpdatePosition(ProfitPosition event, Emitter<ProfitState> emit) {
    emit(
      state.copyWith(
        position: event.position,
      )
    );
  }

  void updatePosition(int position) {
    add(ProfitPosition(position));
  }
}
