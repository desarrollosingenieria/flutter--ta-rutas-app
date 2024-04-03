import 'package:hive_flutter/hive_flutter.dart';

part 'ta_card.g.dart';

@HiveType(typeId: 0)
class TACard {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String color;
  @HiveField(3)
  final String? img;
  @HiveField(4)
  final bool isGroup;
  @HiveField(6)
  final int? parent;
  @HiveField(7)
  final List<int>? children;
  @HiveField(8)
  final int id;

  const TACard({
    required this.name,
    required this.text,
    required this.color,
    this.img,
    required this.isGroup,
    this.parent,
    this.children,
    required this.id,
  });

  TACard copyWith({
    String? name,
    String? text,
    String? color,
    String? img,
    bool? isGroup,
    int? parent,
    List<int>? children,
    int? id,
  }) =>
      TACard(
        name: name ?? this.name,
        text: text ?? this.text,
        color: color ?? this.color,
        img: img ?? this.img,
        isGroup: isGroup ?? this.isGroup,
        parent: parent ?? this.parent,
        children: children ?? this.children,
        id: id ?? this.id,
      );
}
