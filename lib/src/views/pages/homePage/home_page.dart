import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/utils/transitions.dart';
import 'package:tarutas/src/views/pages/configPage/config_page.dart';
import 'package:tarutas/src/views/pages/homePage/widgets/home_group_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(configProvider);
    ref.read(tARoutesProvider.notifier).openCardBox();
    return Scaffold(
      backgroundColor: appConfig.highContrast ? Colors.black : Colors.white,
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              title: const Text(
                'TA Rutas',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: const Color(0xFF003A70),
              centerTitle: true,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeTransitionRoute(
                        widget: const ConfigPage(),
                      ),
                    );
                  },
                ),
              ],
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SafeArea(
                child: SizedBox.shrink(),
              )),
      body: FutureBuilder(
          future: ref.read(tARoutesProvider.notifier).openCardBox(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ValueListenableBuilder(
                  valueListenable: ref
                      .read(tARoutesProvider.notifier)
                      .getSavedRoutes()
                      .listenable(),
                  builder: (context, box, _) {
                    debugPrint('HAY ${box.values.length} RUTAS EN EL BOX');
                    List<dynamic> listCards = [];
                    listCards = box.values
                        .where((card) => card.parent == null)
                        .toList();
                    return HomeGroupWidget(listCards: listCards);
                  },
                ),
              );
            } else {
              return const Center(child: Text('Cargando...'));
            }
          })),
      // bottomNavigationBar: const Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      //   child: PhrasesWidget(),
      // ),
    );
  }
}
