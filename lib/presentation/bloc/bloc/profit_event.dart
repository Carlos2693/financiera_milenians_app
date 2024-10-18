part of 'profit_bloc.dart';

abstract class ProfitEvent {
  const ProfitEvent();
}

class ProfitPosition extends ProfitEvent {
  final int position;

  const ProfitPosition(this.position);
}

// class CounterReset extends CounterEvent {}