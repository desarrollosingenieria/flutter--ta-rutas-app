import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';
import 'package:tarutas/src/models/ta_card.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/provider/tts_provider.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/utils/transitions.dart';
import 'package:tarutas/src/views/pages/homePage/group_page.dart';

class ButtonWidget extends ConsumerWidget {
  final TACard card;
  final int? id;
  const ButtonWidget({super.key, required this.card, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size mq = MediaQuery.of(context).size;
    final UserPreferences prefs = UserPreferences();
    return SizedBox(
      height: mq.width * 0.04,
      child: Material(
        color: card.color.toColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          child: card.img == ''
              ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Center(
                      child: Text(
                        card.name.toUpperCase(),
                        style: TextStyle(
                            //fontSize: MediaQuery.of(context).size.height * 0.1,
                            fontSize: mq.height * 0.03,
                            fontWeight: FontWeight.bold,
                            color: prefs.highContrast
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                    card.isGroup
                        ? Container(
                            margin: const EdgeInsets.all(6),
                            alignment: Alignment.topRight,
                            child: const Icon(
                              Icons.arrow_circle_right_rounded,
                              size: 34,
                              color: ColorApp.brandblue,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.file(
                        File(card.img!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: mq.width * 0.14,
                          width: double.infinity,
                          color: card.color.toColor,
                          alignment: Alignment.center,
                          child: Text(
                            card.name.toUpperCase(),
                            style: TextStyle(
                                //fontSize: MediaQuery.of(context).size.height * 0.1,
                                fontSize: mq.height * 0.03,
                                fontWeight: FontWeight.bold,
                                color: prefs.highContrast
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                      card.isGroup
                          ? Container(
                              margin: const EdgeInsets.all(6),
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.arrow_circle_right_rounded,
                                size: 34,
                                color: card.img != ''
                                    ? card.color.toColor
                                    : ColorApp.brandblue,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
          onTap: () {
            HapticFeedback.lightImpact();
            ref.read(appTTSProvider.notifier).speak(card.text);
            if (card.isGroup) {
              Navigator.push(
                context,
                SlideLeftTransitionRoute(
                  widget: GroupPage(
                    groupName: card.name.toUpperCase(),
                    groupColor: card.color.toColor,
                    idParent: card.id,
                  ),
                ),
              );
            }
          },
          onLongPress: () => showModalBottomSheet<String>(
            context: context,
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    height: mq.width * 0.08,
                    thickness: 4,
                    endIndent: mq.width * 0.4,
                    indent: mq.width * 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Seleccione una acción',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: mq.width * 0.06,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    minVerticalPadding: mq.width * 0.06,
                    title: const Text('Editar ruta'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    title: const Text('Eliminar ruta'),
                    onTap: () {
                      ref.read(tARoutesProvider.notifier).deleteCard(card.id);
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    title: const Text('Cancelar'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
