// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ta_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TACardAdapter extends TypeAdapter<TACard> {
  @override
  final int typeId = 0;

  @override
  TACard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TACard(
      name: fields[0] as String,
      text: fields[1] as String,
      color: fields[2] as Color,
      img: fields[3] as String?,
      isGroup: fields[4] as bool,
      cards: (fields[5] as List?)?.cast<TACard>(),
    );
  }

  @override
  void write(BinaryWriter writer, TACard obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.img)
      ..writeByte(4)
      ..write(obj.isGroup)
      ..writeByte(5)
      ..write(obj.cards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TACardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
