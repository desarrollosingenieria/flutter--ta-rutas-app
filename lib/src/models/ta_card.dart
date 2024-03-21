import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'ta_card.g.dart';

@HiveType(typeId: 0)
class TACard {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final Color color;
  @HiveField(3)
  final String? img;
  @HiveField(4)
  final bool isGroup;
  @HiveField(5)
  final List<TACard>? cards;

  const TACard(
      {required this.name,
      required this.text,
      required this.color,
      this.img,
      required this.isGroup,
      this.cards});
}
