import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cardState.cardModel == null) return;

              ref
                .read(cardFormProvider(cardState.cardModel!).notifier)
                .onFormSubmit();
            },
            child: const Icon(Icons.save_as_outlined),
          )
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

    ref.listen(cardFormProvider(cardModel), (_, next) {
      switch (next.cardFormStatus) {
        case CardFormStatus.saved:
          context.pop();
          break;
        case CardFormStatus.error:
          // WIP
          break;
        default:
      }
    });

    return ListView(
      children: [
        SimpleTextField(
          initialValue: cardForm.alias.value,
          hinttext: 'Ingrese un alias',
          onChanged:
              ref.read(cardFormProvider(cardModel).notifier).onAliasChanged,
          errorMessage: cardForm.isPosted ? cardForm.alias.errorMessage : null,
        ),
        SimpleTextField(
          initialValue: cardForm.cardNumber.value,
          hinttext: 'Número de tarjeta',
          onChanged: ref
              .read(cardFormProvider(cardModel).notifier)
              .onCardNumberChanged,
          errorMessage:
              cardForm.isPosted ? cardForm.cardNumber.errorMessage : null,
          maxLenght: 16,
        ),
        SimpleTextField(
          initialValue: cardForm.nameBank.value,
          hinttext: 'Nombre del banco',
          onChanged:
              ref.read(cardFormProvider(cardModel).notifier).onNameBankChanged,
          errorMessage:
              cardForm.isPosted ? cardForm.nameBank.errorMessage : null,
        ),
        SimpleTextField(
          initialValue: cardForm.ownerName.value,
          hinttext: 'Tarjetahabiente',
          onChanged:
              ref.read(cardFormProvider(cardModel).notifier).onOwnerNameChanged,
          errorMessage:
              cardForm.isPosted ? cardForm.ownerName.errorMessage : null,
        ),
      ],
    );
  }
}
