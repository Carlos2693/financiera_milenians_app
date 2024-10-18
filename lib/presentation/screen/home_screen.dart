import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:financiera_milenians_app/config/theme/app_theme.dart';
import 'package:financiera_milenians_app/presentation/widget/buttons.dart';
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_AmountGrid(), _ProfitList()],
        ),
      ),
    );
  }
}

class _AmountGrid extends StatefulWidget {
  @override
  State<_AmountGrid> createState() => _AmountGridState();
}

class _AmountGridState extends State<_AmountGrid> {
  final List<double> amounts = [1000.0, 5000.0, 10000.0, 15000.0, 20000.0];
  final Map<int, List<double>> mapFactors = {
    1000: [3.5, 4.5, 5.5, 6.0],
    5000: [3.5, 4.5, 5.5, 7.0],
    10000: [4.5, 4.5, 5.5, 8.0],
    15000: [5.5, 6.5, 7.5, 8.8],
    20000: [6.5, 7.5, 8.5, 9.0],
  };
  final int numColumns = 3;
  final currentFormat = NumberFormat.simpleCurrency(
    locale: 'es_MX',
    decimalDigits: 2,
    name: '\$',
  );

  @override
  void initState() {
    updatePosition(context, 0);
    super.initState();
  }

  void updatePosition(BuildContext context, int position) {
    final amount = amounts[position];
    final factors = mapFactors[amount];
    if (factors != null) {
      context.read<ProfitBloc>().updatePosition(position, amount, factors);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0, // Espaciado horizontal entre los elementos
        runSpacing: 8.0, // Espaciado vertical entre las filas
        children: List.generate(amounts.length, (index) {
          return Container(
            width: (MediaQuery.of(context).size.width - 32) /
                numColumns, // Dividimos el ancho en 3 columnas
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ajusta la altura al contenido
              children: [
                context.select((ProfitBloc profitBloc) {
                  return ButtonAnimated(
                    amount: currentFormat.format(amounts[index]),
                    baseColor: profitBloc.state.position == index ? AppTheme.buttonSelectedColor : null,
                    callback: () => { updatePosition(context, index) },
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ProfitList extends StatelessWidget {
  final factorByMonts = 3;
  final currentFormat = NumberFormat.simpleCurrency(
    locale: 'es_MX',
    decimalDigits: 2,
    name: '\$',
  );

  @override
  Widget build(BuildContext context) {
    return context.select((ProfitBloc profitBloc) {
      final amounts = profitBloc.state.amounts;
      const textStyle = TextStyle(fontWeight: FontWeight.bold);

      return Column(
        children: [
          const Text('Ganancias', style: textStyle),
          ...List.generate(amounts.length, (index) {
            final startAmount = amounts[index].startAmount;
            final finalAmount = amounts[index].finalAmount;
            final monthText = factorByMonts * (index + 1);

            final textByMonts =
                Text('Por cada $monthText mes', style: textStyle);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Por cada mes', style: textStyle),
                    textByMonts,
                    Text(currentFormat.format(startAmount)),
                  ],
                ),
                Column(
                  children: [
                    const Text('Ganancial total', style: textStyle),
                    textByMonts,
                    Text(currentFormat.format(finalAmount)),
                  ],
                )
              ],
            );
          }),
        ],
      );
    });
  }
}
