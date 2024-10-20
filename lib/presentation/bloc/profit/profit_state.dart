part of 'profit_bloc.dart';

class ProfitState extends Equatable {

  final int position;
  final List<AmountByMonth> amounts;

  const ProfitState({
    required this.position,
    required this.amounts,
  });

  ProfitState copyWith({
    int? position,
    List<AmountByMonth>? amounts,
  }) => ProfitState(
    position: position ?? this.position,
    amounts: amounts ?? this.amounts,
  );

  @override
  List<Object?> get props => [position];
}
