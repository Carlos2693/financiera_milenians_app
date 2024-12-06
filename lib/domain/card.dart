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
}
