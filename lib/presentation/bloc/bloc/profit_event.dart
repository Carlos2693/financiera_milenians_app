part of 'profit_bloc.dart';

abstract class ProfitEvent {
  const ProfitEvent();
}

class ProfitUpdated extends ProfitEvent {
  final double value;

  const ProfitUpdated(this.value);
}

// class CounterReset extends CounterEvent {}