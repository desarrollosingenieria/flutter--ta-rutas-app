import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/utils/transitions.dart';
import 'package:tarutas/src/views/pages/configPage/config_page.dart';
import 'package:tarutas/src/views/pages/groupPage/widgets/group_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final UserPreferences prefs = UserPreferences();
    final appConfig = ref.watch(configProvider);
    ref.read(tARoutesProvider.notifier).openCardBox();
    //ref.read(cardProvider.notifier).setParentCard();
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
      body: const GroupWidget(),
    );
  }
}
