import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:financiera_milenians_app/presentation/widget/buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static List<double> amounts = [1000.0, 5000.0, 10000.0, 15000.0, 20000.0];
  static int maxByColumn = 3;

  @override
  Widget build(BuildContext context) {
    final currentFormat = NumberFormat.simpleCurrency(locale: 'es_MX', decimalDigits: 2, name: '\$');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grid con Altura Dinámica'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0, // Espaciado horizontal entre los elementos
            runSpacing: 8.0, // Espaciado vertical entre las filas
            children: List.generate(amounts.length, (index) {
              return Container(
                width: (MediaQuery.of(context).size.width - 32) /
                  maxByColumn, // Dividimos el ancho en 3 columnas
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ajusta la altura al contenido
                  children: [
                    // get amount in specific index of amounts list
                    ButtonAnimated(
                      amount: currentFormat.format(amounts[index]),
                      callback: () => {
                        print('Amount: ${amounts[index]}'),
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
