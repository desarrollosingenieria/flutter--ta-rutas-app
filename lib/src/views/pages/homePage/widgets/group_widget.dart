import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/views/pages/homePage/widgets/add_button_widget.dart';
import 'package:tarutas/src/views/pages/homePage/widgets/button_widget.dart';

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
                      return buildGroupWidget(
                          listCards: listCards, parent: idParent);
                    }
                    listCards = box.values
                        .where((card) => card.parent == null)
                        .toList();
                    return buildGroupWidget(listCards: listCards);
                  },
                ),
              );
            } else {
              return const Center(child: Text('Cargando...'));
            }
          })),
    );
  }

  Widget buildGroupWidget({required List<dynamic> listCards, int? parent}) {
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
            return AddButtonWidget(
              idParent: parent,
            );
          }
        }),
      );
    }
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      children: [
        AddButtonWidget(idParent: parent),
      ],
    );
  }
}
