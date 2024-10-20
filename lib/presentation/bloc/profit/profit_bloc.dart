import 'package:financiera_milenians_app/presentation/model/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profit_event.dart';
part 'profit_state.dart';

class ProfitBloc extends Bloc<ProfitEvent, ProfitState> {
  
  ProfitBloc(): super(const ProfitState(position: 0, amounts: [])) {
    on<ProfitPosition>(_onProfitUpdatePosition);
  }

  void _onProfitUpdatePosition(ProfitPosition event, Emitter<ProfitState> emit) {
    final list = _buildAmounts(event.amount, event.factors);
    emit(
      state.copyWith(
        position: event.position,
        amounts: list,
      )
    );
  }

  void updatePosition(int position, double amount, List<double> factors) {
    add(
      ProfitPosition(position, amount, factors)
    );
  }

  _buildAmounts(double amount, List<double> factors) {
    const factorPercentage = 100;
    const factorPerMonth = 3;

    List<AmountByMonth> amounts = [];

    for (final (index, factor) in factors.indexed) {
      final byMonth = amount * factor / factorPercentage;
      final totalProfit = byMonth * factorPerMonth * (index + 1);

      amounts.add(
        AmountByMonth(
          startAmount: byMonth,
          finalAmount: totalProfit,
        )
      );
    }

    return amounts;
  }
}
