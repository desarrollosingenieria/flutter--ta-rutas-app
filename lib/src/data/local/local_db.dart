// ignore_for_file: depend_on_referenced_packages
import 'package:hive/hive.dart';
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

  Box? getCard(int index) {
    return cardBox!.getAt(index);
  }

  void setCard({required TACard card}) {
    final taCard = TACard(
      id: card.id == 99999 ? cardBox!.values.length : card.id,
      name: card.name,
      text: card.text,
      color: card.color,
      img: card.img,
      isGroup: card.isGroup,
      parent: card.parent,
      children: card.children,
    );
    //print('CREANDO RUTA $id DENTRO DE ID: ${taCard.parent}');
    cardBox!.put(taCard.id, taCard);
    if (taCard.parent != null) {
      updateParentCard(idParent: taCard.parent!, idChild: taCard.id);
    }
  }

  void updateParentCard({required int idParent, required int idChild}) {
    //print('ACTUALIZANDO RUTA ID: $idParent');
    final cardParent = cardBox!.getAt(idParent) as TACard;
    TACard newCardParent =
        cardParent.copyWith(children: [...cardParent.children ?? [], idChild]);
    cardBox!.put(idParent, newCardParent);
    //print('RUTA ID $idParent CUENTA CON LAS RUTAS HIJAS: ${newCardParent.children}');
  }

  void deleteCard(int id) {
    cardBox!.getAt(id);
    cardBox!.delete(id);
  }
}
