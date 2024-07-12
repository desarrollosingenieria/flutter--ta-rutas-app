import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/constants/constants.dart';
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
                            card.name.toUpperCase(),
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
                              child: Icon(
                                Icons.arrow_circle_right_rounded,
                                size: 34,
                                color: appConfig.highContrast
                                    ? Colors.black
                                    : TAColors.brandblue,
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
                            ? card.img!.contains(HTTP_EXTENSION)
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
                            : const SizedBox.shrink(),
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
                                child: Icon(
                                  Icons.arrow_circle_right_rounded,
                                  size: 34,
                                  color: card.img != ''
                                      ? card.color.toColor
                                      : TAColors.brandblue,
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
                        title: const Text(EDIT_ROUTE_TEXT),
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
                        leading: const Icon(Icons.delete),
                        title: const Text(DELETE_ROUTE_TEXT),
                        onTap: () {
                          ref
                              .read(tARoutesProvider.notifier)
                              .deleteCard(card.id);
                          if (card.name == TEMPLATE_FAMILY_TITLE) {
                            prefs.templateFamilyLoaded = false;
                          } else if (card.name == TEMPLATE_FLENI_TITLE) {
                            prefs.templateFleniLoaded = false;
                          } else if (card.name == TEMPLATE_HOME_TITLE) {
                            prefs.templateHomeLoaded = false;
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.file_download),
                        title: const Text(SAVE_TEMPLATE),
                        onTap: () async {
                          FilePicker.platform.getDirectoryPath().then((result) {
                            Navigator.of(context).pop();
                            if (result != null) {
                              ref
                                  .read(tARoutesProvider.notifier)
                                  .saveAndExportTemplate(
                                      id: card.id, backupPath: result);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Se ha guardado la plantilla ${card.name}',
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'No se seleccionó una carpeta de destino',
                                  ),
                                ),
                              );
                            }
                          });
                        },
                      ),
                      const Divider(
                        height: 40,
                        color: Colors.black12,
                      ),
                      ListTile(
                        leading: const Icon(Icons.cancel),
                        title: const Text(CANCEL_TEXT),
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
