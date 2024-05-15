import 'dart:io';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';
import 'package:tarutas/src/models/ta_card.dart';
import 'package:tarutas/src/provider/card_provider.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/provider/tts_provider.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/utils/transitions.dart';
import 'package:tarutas/src/views/pages/editPage/edit_page.dart';
import 'package:tarutas/src/views/pages/groupPage/group_page.dart';

class ButtonWidget extends ConsumerWidget {
  final TACard card;
  final int? id;
  const ButtonWidget({super.key, required this.card, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size mq = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    final appConfig = ref.watch(configProvider);
    final prefs = UserPreferences();
    debugPrint(
        'CARD ${card.name} TIENE ID ${card.id} Y SUS HIJOS SON ${card.children}');
    return SizedBox(
      height: mq.width * 0.04,
      child: Material(
        color: card.color.toColor,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            child: card.img == ''
                ? Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            '${card.name.toUpperCase()}',
                            style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? mq.width * appConfig.factorSize
                                    : mq.height * appConfig.factorSize,
                                fontWeight: FontWeight.bold,
                                color: appConfig.highContrast
                                    ? Colors.black
                                    : Colors.white),
                          ),
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
                        card.img != null
                            ? card.img!.contains('http')
                                ? Image.network(
                                    card.img!,
                                    width: double.infinity,
                                    height: mq.width * 0.3,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(card.img!),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                            : SizedBox.shrink(),
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
                                  color: appConfig.highContrast
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
            onLongPress: () => showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        thickness: 4,
                        height: 40,
                        color: Colors.black12,
                        indent: mq.width * 0.4,
                        endIndent: mq.width * 0.4,
                      ),
                      ListTile(
                        minVerticalPadding: mq.width * 0.06,
                        title: const Text('Editar ruta'),
                        leading: const Icon(Icons.edit),
                        onTap: () {
                          ref.read(cardProvider.notifier).setCard(card: card);
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            SlideLeftTransitionRoute(
                              widget: EditPage(
                                card: card,
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        minVerticalPadding: mq.width * 0.06,
                        leading: const Icon(Icons.delete),
                        title: const Text('Eliminar ruta'),
                        onTap: () {
                          ref
                              .read(tARoutesProvider.notifier)
                              .deleteCard(card.id);
                          // SI SE ELIMINA UNA PLANTILLA
                          if (card.name == 'Familia') {
                            prefs.templateFamilyLoaded = false;
                          } else if (card.name == 'Fleni') {
                            prefs.templateFleniLoaded = false;
                          } else if (card.name == 'Casa') {
                            prefs.templateHomeLoaded = false;
                          }
                          // // SE ACTUALIZAN LOS ID DE LAS RUTAS
                          // ref.read(tARoutesProvider.notifier).updateIDCards();
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        minVerticalPadding: mq.width * 0.06,
                        leading: const Icon(Icons.file_download),
                        title: const Text('Guardar plantilla'),
                        onTap: () async {
                          Directory? directory =
                              await getExternalStorageDirectory();
                          // String? directory =
                          //     await FilePicker.platform.getDirectoryPath();

                          // if (directory != null) {
                          //   print(directory);
                          //   ref
                          //     .read(tARoutesProvider.notifier)
                          //     .saveAndExportTemplate(
                          //         id: card.id, backupPath: directory);
                          // } else {
                          //   // Do something else...
                          //}
                          ref
                              .read(tARoutesProvider.notifier)
                              .saveAndExportTemplate(
                                  id: card.id, backupPath: directory!.path);

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Se ha guardado la plantilla ${card.name}',
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        height: 40,
                        color: Colors.black12,
                      ),
                      ListTile(
                        minVerticalPadding: mq.width * 0.06,
                        leading: const Icon(Icons.cancel),
                        title: const Text('Cancelar'),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
