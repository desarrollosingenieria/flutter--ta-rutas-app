import 'dart:io';

import 'package:flutter/material.dart';
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
    localDB.setCard(card: card);
  }

  void deleteCard(int index) {
    // ELIMINACION DE TARJETA Y SUS HIJOS
    print('SE QUIERE ELIMINAR $index');
    TACard card = localDB.cardBox!.get(index) as TACard;
    if (card.children!.isNotEmpty) {
      debugPrint('${card.children!.length} HIJOS: ${card.children}');
      for (int i = card.children!.length - 1; i >= 0; i--) {
        debugPrint('PROBANDO ELIMINAR ${card.children![i]}');
        deleteCard(card.children![i]);
      }
    }

    debugPrint('BORRANDO CARD $index');
    localDB.deleteCard(index);
  }

  Future<void> saveAndExportTemplate(
      {required int id, required String backupPath}) async {
    // SE EXPORTA LA PLANTILLA
    // PRIMERO PASAMOS LA TARJETA Y SUS HIJAS AL BOX BACKUP
    TACard card = localDB.cardBox!.get(id) as TACard;
    final box = localDB.backupBox;
    final boxPath = box!.path!;
    // SE GUARDAN LAS RUTAS
    _saveTemplate(id);
    // SE CIERRA EL BOX BACKUP
    await box.close();
    // SE REALIZA LA COPIA DE SEGURIDAD
    _exportTemplate(
        cardTitle: card.name, boxPath: boxPath, backupPath: backupPath);
    _clearBackupBox();
  }

  void _saveTemplate(int index) {
    //File(boxPath).copy(backupPath);
    TACard card = localDB.cardBox!.get(index) as TACard;
    if (card.children!.isNotEmpty) {
      debugPrint('${card.children!.length} HIJOS: ${card.children}');
      for (int i = card.children!.length - 1; i >= 0; i--) {
        _saveTemplate(card.children![i]);
      }
    }
    debugPrint('AGREGANDO A BACKUP $index');
    localDB.backupRoute(id: index);
    //await localDB.backupBox!.close();
    //print('BACKUPBOX ESTÁ EN: ${File(Hive.box('backup').path!)}');
  }

  Future<void> _exportTemplate(
      {required cardTitle,
      required String boxPath,
      required String backupPath}) async {
    backupPath =
        '$backupPath/$cardTitle-${DateTime.now().day.toString().padLeft(2, '0')}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().year}-backup.hive';

    try {
      await File(boxPath).copy(backupPath);
    } catch (e) {
      print(e);
    }

    print('COPIA DE SEGURIDAD REALIZADA');
  }

  Future<void> importTemplate({required String backupPath}) async {
    Box? box = localDB.backupBox;
    final boxPath = box!.path!;
    await box.close();
    File(backupPath).copy(boxPath); // copy backup file
    await localDB.openBox();
    final parentCard = localDB.backupBox!.values.first as TACard;
    _loadTemplate(id: parentCard.id);
    _clearBackupBox();
  }

  Future<void> _loadTemplate({required int id, int? parentId}) async {
    int newId =
        localDB.cardBox!.isNotEmpty ? localDB.cardBox!.values.last.id + 1 : 0;
    final TACard card = localDB.backupBox!.get(id) as TACard;
    TACard restoredCard = TACard(
      id: newId,
      name: card.name,
      text: card.text,
      color: card.color,
      img: '',
      isGroup: card.isGroup,
      parent: parentId,
      children: card.children,
    );
    localDB.setCard(card: restoredCard);
    debugPrint('${card.name} TIENE PADRE ${restoredCard.parent}');
    if (card.children!.isNotEmpty) {
      debugPrint(
          '${card.name} TIENE ${card.children!.length} HIJOS: ${card.children}');
      for (int i = 0; i < card.children!.length; i++) {
        _loadTemplate(id: card.children![i], parentId: restoredCard.id);
      }
      // ACTUALIZO LA LISTA DE HIJOS EN PADRE
      List<int>? childrenID = [];
      List children = localDB.cardBox!.values
          .where((child) => child.parent == restoredCard.id)
          .toList();
      children.forEach((child) => childrenID.add(child.id));
      debugPrint(
          'LOS NUEVOS HIJOS DE ${restoredCard.name} (ID ${restoredCard.id}) SON: ${childrenID}');
      restoredCard = restoredCard.copyWith(children: childrenID);
      localDB.setCard(card: restoredCard);
    }
  }

  Future<void> _clearBackupBox() async {
    await localDB.openBox();
    await localDB.backupBox!.clear();
    print('BACKUPBOX  IS CLEAR');
  }

  void updateIDCards() {
    localDB.updateIDCards();
  }

  void deleteAllCards() {
    localDB.cardBox!.clear();
  }
}
