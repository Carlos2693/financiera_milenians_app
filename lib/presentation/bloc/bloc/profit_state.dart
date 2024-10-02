part of 'profit_bloc.dart';

class ProfitState extends Equatable {

  final double initAmount;
  final double finalAmount;

  const ProfitState({
    required this.initAmount,
    required this.finalAmount,
  });

  ProfitState copyWith({
    double? initAmount,
    double? finalAmount,
  }) => ProfitState(
    initAmount: initAmount ?? this.initAmount,
    finalAmount: finalAmount ?? this.finalAmount,
  );

  @override
  List<Object?> get props => [initAmount, finalAmount];
}
