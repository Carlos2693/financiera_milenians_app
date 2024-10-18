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
        child: _AmountGrid(),
      ),
    );
  }
}

class _AmountGrid extends StatelessWidget {
  final List<double> amounts = [1000.0, 5000.0, 10000.0, 15000.0, 20000.0];
  final int numColumns = 3;
  final currentFormat = NumberFormat.simpleCurrency(
      locale: 'es_MX', decimalDigits: 2, name: '\$');

  void updatePosition(BuildContext context, int position) {
    context.read<ProfitBloc>().updatePosition(position);
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
