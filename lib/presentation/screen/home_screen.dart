import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:financiera_milenians_app/presentation/bloc/bloc/profit_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfitBloc(),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  void increaseCounter(BuildContext context, [double value = 1.0]) {
    context.read<ProfitBloc>().increaseBy(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Result expected'),
            context.select((ProfitBloc profitBloc) => Text('${profitBloc.state.finalAmount}')),
            OutlinedButton(
              child: const Text('Press me!'),
              onPressed: () => increaseCounter(context),
            )
          ],
        ),
      ),
    );
  }
}
