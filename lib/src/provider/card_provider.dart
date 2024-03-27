import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tarutas/src/models/ta_card.dart';

part 'card_provider.g.dart';

@Riverpod(keepAlive: true)
class Card extends _$Card {
  @override
  TACard build() => const TACard(
        id: 0,
        name: '',
        text: '',
        color: '0xff9e9e9e',
        isGroup: false,
        parent: null,
        img: '',
      );

  void restartCard({int? idParent}) {
    print('RESTABLECIENDO CARD HIJA DE $idParent');
    state = TACard(
      id: 0,
      name: '',
      text: '',
      color: '0xff9e9e9e',
      isGroup: false,
      parent: idParent,
      img: '',
    );
    print(state.parent);
  }

  void setParentCard({int? idParent}) {
    print('SETEANDO PADRE: $idParent');
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
