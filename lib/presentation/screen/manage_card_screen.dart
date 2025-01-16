import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/presentation/provider/card_provider.dart';
import 'package:financiera_milenians_app/presentation/provider/form/card_form_provider.dart';
import 'package:financiera_milenians_app/presentation/widget/textfields.dart';
import 'package:financiera_milenians_app/shared/shared.dart';

class ManageCardScreen extends ConsumerWidget {
  final String cardId;

  const ManageCardScreen({
    super.key,
    required this.cardId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardState = ref.watch(cardProvider(cardId));

    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cardId == 'new' ? 'Registrar' : 'Actualizar'
          ),
        ),

        body: cardState.isLoading
          ? const FullScreenLoader()
          : _CardView(cardModel: cardState.cardModel!),
      ),
    );
  }
}

class _CardView extends ConsumerWidget {
  final CardModel cardModel;

  const _CardView({required this.cardModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardForm = ref.watch(cardFormProvider(cardModel));

    return ListView(
      children: [
        SimpleTextField(
          initialValue: cardForm.alias.value,
          hinttext: 'Ingrese un alias',
        ),
        SimpleTextField(
          initialValue: cardForm.cardNumber.value,
          hinttext: 'Número de tarjeta'
        ),
        SimpleTextField(
          initialValue: cardForm.nameBank.value,
          hinttext: 'Nombre del banco'
        ),
        SimpleTextField(
          initialValue: cardForm.ownerName.value,
          hinttext: 'Tarjetahabiente'
        ),
      ],
    );
  }
}
