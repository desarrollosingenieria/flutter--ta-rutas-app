// ignore_for_file: depend_on_referenced_packages

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarutas/src/models/ta_card.dart';

class LocalData {
  var initialized = false;
  Box? cardBox;

  Future<bool> init() async {
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TACardAdapter());
    }
    return true;
  }

  Future<bool> openBox() async {
    cardBox = await Hive.openBox<TACard>('card');
    return true;
  }

  Box? getCards() {
    return cardBox;
  }

  void setCard(TACard card) {
    cardBox!.add(card);
  }

  void deleteCard(int id) {
    cardBox!.deleteAt(id);
  }
}
