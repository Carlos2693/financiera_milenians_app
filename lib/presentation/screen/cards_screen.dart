import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:financiera_milenians_app/config/constant/constant.dart';
import 'package:financiera_milenians_app/domain/entity/card.dart';
import 'package:financiera_milenians_app/domain/repository/card_provider.dart';

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

    final cardList = ref.watch(cardsProvider).values.toList();
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
              final cardNumber = card.cardNumber;

              return _ListItemCard(card: card, cardNumber: cardNumber);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () => {context.push('/register_card/new')},
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

class _ListItemCard extends StatelessWidget {
  static String bankPrefix = "Banco";

  final CardModel card;
  final String cardNumber;

  const _ListItemCard({
    required this.card,
    required this.cardNumber,
  });

  TextStyle _textStyleFontSize(double fontSize) {
    return TextStyle(fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context) {
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
                  Constant.mask + card.cardNumber.substring(cardNumber.length - 4),
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
            onPressed: () {
              // WIP
            },
            style: IconButton.styleFrom(backgroundColor: Colors.blue),
            icon: const Icon(Icons.edit),
          ),
          IconButton.filled(
            onPressed: () {
              // WIP
            },
            style: IconButton.styleFrom(backgroundColor: Colors.blue),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
