import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:financiera_milenians_app/config/constant/constant.dart';
import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/presentation/provider/cards_provider.dart';
import 'package:financiera_milenians_app/presentation/provider/form/card_form_provider.dart';

class CardsScreen extends ConsumerStatefulWidget {
  const CardsScreen({super.key});

  @override
  CardsScreenState createState() => CardsScreenState();
}

class CardsScreenState extends ConsumerState<CardsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    await ref.read(cardsProvider.notifier).loadCards();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final cardList = ref.watch(cardsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjetas registradas'),
      ),
      body: Builder(
        builder: (context) {
          if (cardList.isEmpty) {
            return const Align(
              alignment: Alignment.center,
              child: Text('Esperando el registro de una tarjeta'),
            );
          }
          return ListView.builder(
            itemCount: cardList.length,
            itemBuilder: (context, index) {

              final card = cardList[index];

              return _ListItemCard(card: card);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () => context.push('/register_card/new'),
        label: const Text(
          'Agregar',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListItemCard extends ConsumerWidget {
  static String bankPrefix = "Banco";

  final CardModel card;

  const _ListItemCard({
    required this.card,
  });

  TextStyle _textStyleFontSize(double fontSize) {
    return TextStyle(fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.alias,
                  style: _textStyleFontSize(20),
                ),
                Text(
                  Constant.mask +
                      card.cardNumber.substring(card.cardNumber.length - 4),
                  style: _textStyleFontSize(20),
                ),
                Text(
                  '$bankPrefix ${card.nameBank}',
                  style: _textStyleFontSize(16),
                ),
              ],
            ),
          ),
          IconButton.filled(
            onPressed: () => context.push('/register_card/${card.id}'),
            style: IconButton.styleFrom(backgroundColor: Colors.blue),
            icon: const Icon(Icons.edit),
          ),
          IconButton.filled(
            onPressed: () {
              final cardId = card.id;
              if (cardId != null) {
                ref.read(cardFormProvider(card).notifier).onCardDelete(cardId);
              }
            },
            style: IconButton.styleFrom(backgroundColor: Colors.blue),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
