// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarutas/src/models/ta_card.dart';

class LocalData {
  var initialized = false;
  Box? cardBox;
  Box? backupBox;

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
    backupBox = await Hive.openBox<TACard>('backup');

    return true;
  }

  Box? getCards() {
    return cardBox;
  }

  // SET AND GET BACKUP ROUTES - PLANTILLAS
  Box? restoreRoutes() {
    return backupBox;
  }

  Box? restoreRoute(int index) {
    return backupBox!.getAt(index);
  }

  void backupRoute({required int id}) {
    final TACard card = cardBox!.get(id);
    final taCard = TACard(
      id: card.id,
      name: card.name,
      text: card.text,
      isGroup: card.isGroup,
      parent: card.parent,
      children: card.children,
      color: card.color,
    );
    //debugPrint('CREANDO RUTA $id DENTRO DE ID: ${taCard.parent}');
    backupBox!.put(id, taCard);
    print('backupBox TIENE ${backupBox!.length} RUTAS');
  }
  //

  Box? getCard(int index) {
    return cardBox!.getAt(index);
  }

  void setCard({required TACard card}) {
    int nextID = 0;
    if (cardBox!.values.isNotEmpty) {
      nextID = cardBox!.values.last.id + 1;
    }
    debugPrint('LA RUTA ${card.name} TENDRÁ ID: $nextID');
    final taCard = TACard(
      id: card.id == 99999 ? nextID : card.id,
      name: card.name,
      text: card.text,
      color: card.color,
      img: card.img,
      isGroup: card.isGroup,
      parent: card.parent,
      children: card.children,
    );
    //debugPrint('CREANDO RUTA $id DENTRO DE ID: ${taCard.parent}');
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
    //debugPrint('ACTUALIZANDO RUTA ID: $idParent');
    final cardParent = cardBox!.get(idParent) as TACard;
    TACard newCardParent = cardParent;
    if (operation == 'add') {
      newCardParent = cardParent
          .copyWith(children: [...cardParent.children ?? [], idChild]);
    } else {
      newCardParent.children!.remove(idChild);
    }
    cardBox!.put(idParent, newCardParent);
    //debugPrint('RUTA ID $idParent CUENTA CON LAS RUTAS HIJAS: ${newCardParent.children}');
  }

  // RESTORE BACKUP BOX
  void updateParentBackup({required int id, required int idParent}) {
    TACard card = cardBox!.get(id) as TACard;
    card = card.copyWith(parent: idParent);
    cardBox!.put(id, card);
  }

  void updateChildBackup(
      {required int id, required int idChild, required int newIdChild}) {
    TACard card = cardBox!.get(id) as TACard;
    card.children!.remove(idChild);
    card = card.copyWith(children: [...card.children ?? [], newIdChild]);
    cardBox!.put(id, card);
  }

  void updateIDCards() {
    Box<dynamic> box = cardBox!;
    for (int i = 0; i < box.values.length; i++) {
      TACard card = box.getAt(i);
      debugPrint('CARD $i TIENE ID: ${card.id}');
      if (card.id != i) {
        debugPrint('ACTUALIZANDO CARD ID');
        card = card.copyWith(
          id: i,
        );
        box.putAt(i, card);
        if (card.children!.isNotEmpty) {
          for (int j = 0; j < card.children!.length; i++) {
            TACard child = box.getAt(i);
            debugPrint('CHILD $i TIENE PARENT: ${child.parent}');
            child = card.copyWith(
              parent: card.id,
            );
          }
        }
        // if (parent != null) {}
        debugPrint('AHORA CARD $i TIENE ID: ${card.id}');
      }
    }
  }

  void deleteCard(int id) {
    final TACard card = cardBox!.get(id);

    if (card.parent != null) {
      debugPrint('ACTUALIZANDO LA RUTA PADRE: ${card.parent}');
      updateParentCard(
          idParent: card.parent!, idChild: card.id, operation: 'remove');
      // ACTUALIZAR PADRE
    }

    cardBox!.delete(id);
  }
}
