import 'package:financiera_milenians_app/config/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

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

              return ListTile(
                title: Text(
                  Constant.mask +  card.cardNumber.substring(cardNumber.length - 4),
                  style: const TextStyle(fontSize: 18.0)
                ),
                subtitle: Text(
                  card.alias,
                  style: const TextStyle(fontSize: 16.0)
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.transparent)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      card.nameBank,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () => context.push('/register_card'),
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
