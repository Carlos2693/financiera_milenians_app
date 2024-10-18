part of 'profit_bloc.dart';

class ProfitState extends Equatable {

  final int position;

  const ProfitState({
    required this.position,
  });

  ProfitState copyWith({
    int? position,
  }) => ProfitState(
    position: position ?? this.position,
  );

  @override
  List<Object?> get props => [position];
}
