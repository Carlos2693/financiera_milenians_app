
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/domain/repository/card_provider.dart';
import 'package:financiera_milenians_app/presentation/widget/textfields.dart';

class RegisterCardScreen extends ConsumerWidget {
  const RegisterCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const colorWhite = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar tarjeta'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleTextField(hinttext: 'Ingresa un alias a la tarjeta'),
          SimpleTextField(hinttext: 'Ingresa el nombre del dueño'),
          SimpleTextField(hinttext: 'Ingresa el banco de la tarjeta'),
          SimpleTextField(hinttext: 'Ingresa el número de la tarjeta'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () async {
          //! WIP send data from form
          final cardModel = CardModel(
            alias: 'Alias',
            ownerName: 'ownerName',
            nameBank: 'nameBank',
            cardNumber: 'cardNumber'
          );

          await ref.read(cardsProvider.notifier).registerCard(cardModel);
          //! WIP remove this sentence
          print('Card was add');
        },
        label: const Text(
          'Guardar',
          style: TextStyle(color: colorWhite),
        ),
        icon: const Icon(Icons.save_as_outlined, color: colorWhite),
      ),
    );
  }
}
