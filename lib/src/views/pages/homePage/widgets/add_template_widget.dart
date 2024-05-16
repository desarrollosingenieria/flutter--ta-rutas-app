import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarutas/src/constants/constants.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/utils/utils.dart';

class AddTemplateWidget extends ConsumerWidget {
  final int? idParent;
  const AddTemplateWidget({
    super.key,
    this.idParent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size mq = MediaQuery.of(context).size;
    final appConfig = ref.watch(configProvider);
    Orientation orientation = MediaQuery.of(context).orientation;
    final prefs = UserPreferences();
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.black.withOpacity(0.05),
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: orientation == Orientation.portrait
                    ? mq.width * appConfig.factorSize * 2
                    : mq.height * appConfig.factorSize * 2,
                color: appConfig.highContrast ? Colors.white : Colors.grey,
              ),
              Text(
                'Plantilla',
                style: TextStyle(
                    //fontSize: MediaQuery.of(context).size.height * 0.1,
                    fontSize: orientation == Orientation.portrait
                        ? mq.width * appConfig.factorSize
                        : mq.height * appConfig.factorSize,
                    fontWeight: FontWeight.bold,
                    color: appConfig.highContrast ? Colors.white : Colors.grey),
              )
            ],
          ),
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Divider(
                      thickness: 4,
                      height: 40,
                      color: Colors.black12,
                      indent: mq.width * 0.4,
                      endIndent: mq.width * 0.4,
                    ),
                    ListTile(
                      minVerticalPadding: mq.width * 0.06,
                      leading: const Icon(Icons.family_restroom),
                      title: const Text('Usar plantilla FAMILIA'),
                      enabled: prefs.templateFamilyLoaded ? false : true,
                      onTap: () async {
                        final String path =
                            await loadTemplates(TEMPLATE_FAMILY);
                        ref
                            .read(tARoutesProvider.notifier)
                            .importTemplate(backupPath: path);
                        prefs.templateFamilyLoaded = true;
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      minVerticalPadding: mq.width * 0.06,
                      leading: const Icon(Icons.home),
                      title: const Text('Usar plantilla CASA'),
                      enabled: prefs.templateHomeLoaded ? false : true,
                      onTap: () async {
                        final String path = await loadTemplates(TEMPLATE_HOME);
                        ref
                            .read(tARoutesProvider.notifier)
                            .importTemplate(backupPath: path);
                        prefs.templateHomeLoaded = true;
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      minVerticalPadding: mq.width * 0.06,
                      leading: const Icon(Icons.map),
                      title: const Text('Usar plantilla FLENI'),
                      enabled: prefs.templateFleniLoaded ? false : true,
                      onTap: () async {
                        final String path = await loadTemplates(TEMPLATE_FLENI);
                        ref
                            .read(tARoutesProvider.notifier)
                            .importTemplate(backupPath: path);
                        prefs.templateFleniLoaded = true;
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(
                      height: 40,
                      color: Colors.black12,
                    ),
                    ListTile(
                      minVerticalPadding: mq.width * 0.06,
                      leading: const Icon(Icons.folder),
                      title: const Text('Importar plantilla desde...'),
                      onTap: () async {
                        Directory? directory =
                            await getExternalStorageDirectory();
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          initialDirectory: directory!.path,
                          type: FileType.any,
                        );

                        if (result != null &&
                            result.files.single.extension == 'hive') {
                          File file = File(result.files.single.path!);
                          ref
                              .read(tARoutesProvider.notifier)
                              .importTemplate(backupPath: file.path);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'El archivo seleccionado no tiene un formato válido. Vuelva a intentarlo.',
                              ),
                            ),
                          );
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void showCustomDialog() {}
}
