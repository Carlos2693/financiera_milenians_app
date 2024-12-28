import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:financiera_milenians_app/presentation/provider/storage/card_form_provider.dart';
import 'package:financiera_milenians_app/presentation/widget/textfields.dart';

class RegisterCardScreen extends ConsumerWidget {
  const RegisterCardScreen({super.key});

  _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const colorWhite = Colors.white;
    final cardForm = ref.watch(cardFormProvider);

    ref.listen(cardFormProvider, (_, next) {
      switch (next.status) {
        case CardFormStatus.error:
          _showSnackBar(context, "Algo salió mal en su registro");
          break;
        case CardFormStatus.saved:
          context.pop();
          break;
        default:
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar tarjeta'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleTextField(
            hinttext: 'Ingresa un alias a la tarjeta',
            onChanged: ref.read(cardFormProvider.notifier).onAliasChange,
            errorMessage:
              cardForm.isFormPosted ? cardForm.alias.errorMessage : null,
          ),
          SimpleTextField(
            hinttext: 'Ingresa el nombre del dueño',
            onChanged: ref.read(cardFormProvider.notifier).onOwnerNameChange,
            errorMessage:
              cardForm.isFormPosted ? cardForm.ownerName.errorMessage : null,
          ),
          SimpleTextField(
            hinttext: 'Ingresa el banco de la tarjeta',
            onChanged: ref.read(cardFormProvider.notifier).onNameBankChange,
            errorMessage:
              cardForm.isFormPosted ? cardForm.nameBank.errorMessage : null,
          ),
          SimpleTextField(
            hinttext: 'Ingresa el número de la tarjeta',
            onChanged: ref.read(cardFormProvider.notifier).onCardNumberChange,
            errorMessage:
              cardForm.isFormPosted ? cardForm.cardNumber.errorMessage : null,
            textInputAction: TextInputAction.done,
            maxLenght: 16,
            onSubmitted: (_) async {
              await ref.read(cardFormProvider.notifier).onFormSubmit();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () async {
          await ref.read(cardFormProvider.notifier).onFormSubmit();
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
