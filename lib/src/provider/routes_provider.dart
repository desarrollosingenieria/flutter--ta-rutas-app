import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tarutas/src/data/local/local_db.dart';
import 'package:tarutas/src/models/ta_card.dart';

part 'routes_provider.g.dart';

@Riverpod(keepAlive: true)
class TARoutes extends _$TARoutes {
  final LocalData localDB = LocalData();

  @override
  List<TACard> build() => [];

  Box getSavedRoutes() {
    Box box = localDB.getCards()!;
    return box;
  }

  Future<bool> openCardBox() async {
    bool result = false;
    await localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        result = true;
      }
    });
    return result;
  }

  void setCard({required TACard card}) {
    //print('POR CONSTRUIR CARD CON PADRE ${card.parent}');
    localDB.setCard(card: card);
  }

  void deleteCard(int index) {
    //print('BORRANDO CARD $index');
    localDB.deleteCard(index);
  }
}
