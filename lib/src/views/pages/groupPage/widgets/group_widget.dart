import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/views/widgets/add_button_widget.dart';
import 'package:tarutas/src/views/widgets/button_widget.dart';

class GroupWidget extends ConsumerWidget {
  final int? idParent;
  const GroupWidget({super.key, this.idParent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(configProvider);
    return Scaffold(
      backgroundColor: appConfig.highContrast ? Colors.black : Colors.white,
      body: FutureBuilder(
          future: ref.read(tARoutesProvider.notifier).openCardBox(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ValueListenableBuilder(
                  valueListenable: ref
                      .read(tARoutesProvider.notifier)
                      .getSavedRoutes()
                      .listenable(),
                  builder: (context, box, _) {
                    List<dynamic> listCards = [];
                    if (idParent != null) {
                      listCards = box.values
                          .where((card) => card.parent == idParent)
                          .toList();
                      return buildGroupWidget(context,
                          listCards: listCards, parent: idParent);
                    }
                    listCards = box.values
                        .where((card) => card.parent == null)
                        .toList();
                    return buildGroupWidget(context, listCards: listCards);
                  },
                ),
              );
            } else {
              return const Center(child: Text('Cargando...'));
            }
          })),
    );
  }

  Widget buildGroupWidget(BuildContext context,
      {required List<dynamic> listCards, int? parent}) {
    final Size mq = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    final UserPreferences prefs = UserPreferences();

    if (listCards.isNotEmpty) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: listCards.length + 1,
        itemBuilder: ((_, index) {
          if (index < listCards.length) {
            return ButtonWidget(
              card: listCards[index],
              id: index,
            );
          } else {
            if (prefs.editMode) {
              return AddButtonWidget(
                idParent: parent,
              );
            }
            return const SizedBox.shrink();
          }
        }),
      );
    }
    return prefs.editMode
        ? GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            children: [AddButtonWidget(idParent: parent)],
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: prefs.highContrast
                            ? Colors.white24
                            : Colors.black12,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.edit,
                      color: prefs.highContrast ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: mq.width * 0.04,
                  ),
                  Text(
                    'Habilite el Modo Editor en configuraciones para agregar nuevas rutas.',
                    style: TextStyle(
                      color: prefs.highContrast ? Colors.white : Colors.black,
                      fontSize: orientation == Orientation.portrait
                          ? mq.width * prefs.factorSize
                          : mq.height * prefs.factorSize,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
