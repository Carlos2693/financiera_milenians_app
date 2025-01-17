import 'package:isar/isar.dart';

part 'card.g.dart';

@collection
class CardModel {
  Id? id;
  final String alias;
  final String ownerName;
  final String nameBank;
  final String cardNumber;

  CardModel({
    required this.alias,
    required this.ownerName,
    required this.nameBank,
    required this.cardNumber,
  });

  CardModel copyWith({
    int? id,
    String? alias,
    String? ownerName,
    String? nameBank,
    String? cardNumber,
  }) {
    final cardModel = CardModel(
      alias: alias ?? this.alias,
      ownerName: ownerName ?? this.ownerName,
      nameBank: nameBank ?? this.nameBank,
      cardNumber: cardNumber ?? this.cardNumber,
    );
    cardModel.id = id;
    return cardModel;
  }
}
