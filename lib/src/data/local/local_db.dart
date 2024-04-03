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
    print('${cardBox!.values.last.id + 1}');
    final taCard = TACard(
      id: card.id == 99999 ? cardBox!.values.last.id + 1 : card.id,
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
    if (taCard.parent != null && card.id == 99999) {
      updateParentCard(
          idParent: taCard.parent!, idChild: taCard.id, operation: 'add');
    }
  }

  void updateParentCard(
      {required int idParent,
      required int idChild,
      required String operation}) {
    //print('ACTUALIZANDO RUTA ID: $idParent');
    final cardParent = cardBox!.get(idParent) as TACard;
    TACard newCardParent = cardParent;
    if (operation == 'add') {
      newCardParent = cardParent
          .copyWith(children: [...cardParent.children ?? [], idChild]);
    } else {
      newCardParent.children!.remove(idChild);
    }
    cardBox!.put(idParent, newCardParent);
    //print('RUTA ID $idParent CUENTA CON LAS RUTAS HIJAS: ${newCardParent.children}');
  }

  void updateIDCards() {
    Box<dynamic> box = cardBox!;
    for (int i = 0; i < box.values.length; i++) {
      TACard card = box.getAt(i);
      print('CARD $i TIENE ID: ${card.id}');
      if (card.id != i) {
        print('ACTUALIZANDO CARD ID');
        card = card.copyWith(
          id: i,
        );
        box.putAt(i, card);
        if (card.children!.isNotEmpty) {
          for (int j = 0; j < card.children!.length; i++) {
            TACard child = box.getAt(i);
            print('CHILD $i TIENE PARENT: ${child.parent}');
            child = card.copyWith(
              parent: card.id,
            );
          }
        }
        // if (parent != null) {}
        print('AHORA CARD $i TIENE ID: ${card.id}');
      }
    }
  }

  void deleteCard(int id) {
    final TACard card = cardBox!.get(id);

    if (card.parent != null) {
      print('ACTUALIZANDO LA RUTA PADRE: ${card.parent}');
      updateParentCard(
          idParent: card.parent!, idChild: card.id, operation: 'remove');
      // ACTUALIZAR PADRE
    }

    cardBox!.delete(id);
  }
}
