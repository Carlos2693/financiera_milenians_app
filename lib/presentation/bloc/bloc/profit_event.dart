part of 'profit_bloc.dart';

abstract class ProfitEvent {
  const ProfitEvent();
}

class ProfitPosition extends ProfitEvent {
  final int position;
  final double amount;
  final List<double> factors;

  const ProfitPosition(this.position, this.amount, this.factors);
}
