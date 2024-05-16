import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tarutas/src/models/ta_card.dart';

part 'card_provider.g.dart';

@Riverpod(keepAlive: true)
class Card extends _$Card {
  @override
  TACard build() => TACard.empty;

  void setCard({required TACard card}) {
    state = card;
  }

  void restartCard({int? idParent}) {
    state = TACard.empty;
  }

  void setParentCard({int? idParent}) {
    state = state.copyWith(
      parent: idParent,
    );
  }

  void setTitleCard({required String title}) {
    state = state.copyWith(
      name: title,
    );
  }

  void setTextCard({required String text}) {
    state = state.copyWith(
      text: text,
    );
  }

  void setColorCard({required String color}) {
    state = state.copyWith(
      color: color,
    );
  }

  void setImgCard({String? img}) {
    state = state.copyWith(img: img);
  }

  void isGroupCard({required bool isGroup}) {
    state = state.copyWith(
      isGroup: isGroup,
    );
  }
}
