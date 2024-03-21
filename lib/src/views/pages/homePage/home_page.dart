import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/models/ta_card.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/utils/transitions.dart';
import 'package:tarutas/src/views/pages/configPage/config_page.dart';
import 'package:tarutas/src/views/pages/homePage/widgets/add_button_widget.dart';
import 'package:tarutas/src/views/pages/homePage/widgets/button_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final UserPreferences prefs = UserPreferences();
    final appConfig = ref.watch(configProvider);
    return Scaffold(
        backgroundColor: appConfig.highContrast ? Colors.black : Colors.white,
        appBar: MediaQuery.of(context).orientation == Orientation.portrait
            ? AppBar(
                title: const Text(
                  'TA Rutas',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: const Color(0xFF003A70),
                centerTitle: true,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            children: const [
              ButtonWidget(
                  card: TACard(
                      name: 'Familia',
                      text: 'Mi familia',
                      color: Colors.blue,
                      isGroup: true)),
              ButtonWidget(
                  card: TACard(
                      name: 'Casa',
                      text: 'Mi casa',
                      color: Colors.green,
                      isGroup: true)),
              ButtonWidget(
                  card: TACard(
                      name: 'Fleni',
                      text: 'Fleni',
                      color: Colors.deepOrange,
                      isGroup: true)),
              AddButtonWidget(),
            ],
          ),
        ));
  }
}
