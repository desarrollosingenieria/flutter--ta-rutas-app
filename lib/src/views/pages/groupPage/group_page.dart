import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tarutas/src/constants/constants.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/views/pages/groupPage/widgets/group_widget.dart';

class GroupPage extends ConsumerWidget {
  final String? groupName;
  final Color? groupColor;
  final int? idParent;
  const GroupPage({super.key, this.groupName, this.groupColor, this.idParent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(configProvider);
    return Scaffold(
      backgroundColor: appConfig.highContrast ? Colors.black : Colors.white,
      appBar: AppBar(
              title: Text(
                groupName ?? APP_NAME,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: groupColor ?? TAColors.brandblue,
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              elevation: 0,
            )
          ,
      body: FutureBuilder(
          future: ref.read(tARoutesProvider.notifier).openCardBox(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding:
                    const EdgeInsets.all(10.0),
                child: ValueListenableBuilder(
                  valueListenable: ref
                      .read(tARoutesProvider.notifier)
                      .getSavedRoutes()
                      .listenable(),
                  builder: (context, box, _) {
                    List<dynamic> listCards = [];

                    listCards = box.values
                        .where((card) => card.parent == idParent)
                        .toList();
                    return GroupWidget(
                        listCards: listCards, idParent: idParent);
                  },
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          })),
    );
  }
}
