import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/constants/constants.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/provider/tts_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigPage extends ConsumerWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserPreferences prefs = UserPreferences();
    final appConfig = ref.watch(configProvider);
    Size mq = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: prefs.highContrast ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text(
          CONFIG_PAGE,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF003A70),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Volumen',
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * appConfig.factorSize
                            : mq.height * appConfig.factorSize,
                        fontWeight: FontWeight.bold,
                        color: prefs.highContrast
                            ? Colors.white
                            : const Color(0xFF003A70),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        ref.read(configProvider.notifier).setVolume(-0.05);
                      },
                      borderRadius: BorderRadius.circular(500),
                      child: Container(
                        alignment: Alignment.center,
                        width: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        height: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: prefs.volume > 0.05
                              ? prefs.highContrast
                                  ? Colors.white
                                  : const Color(0xFF003A70)
                              : prefs.highContrast
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          color:
                              prefs.highContrast ? Colors.black : Colors.white,
                          size: orientation == Orientation.portrait
                              ? mq.width * 0.06
                              : mq.height * 0.06,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: orientation == Orientation.portrait
                          ? mq.width * 0.3
                          : mq.height * 0.3,
                      child: Text(
                        '${(appConfig.ttsVolume * 100).round()}',
                        style: TextStyle(
                          fontSize: orientation == Orientation.portrait
                              ? mq.width * appConfig.factorSize
                              : mq.height * appConfig.factorSize,
                          fontWeight: FontWeight.normal,
                          color: prefs.highContrast
                              ? Colors.white
                              : const Color(0xFF003A70),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ref.read(configProvider.notifier).setVolume(0.05);
                      },
                      borderRadius: BorderRadius.circular(500),
                      child: Container(
                        alignment: Alignment.center,
                        width: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        height: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: appConfig.ttsVolume < 1
                              ? prefs.highContrast
                                  ? Colors.white
                                  : const Color(0xFF003A70)
                              : prefs.highContrast
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color:
                              prefs.highContrast ? Colors.black : Colors.white,
                          size: orientation == Orientation.portrait
                              ? mq.width * 0.06
                              : mq.height * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: orientation == Orientation.portrait
                    ? mq.width * 0.04
                    : mq.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Velocidad',
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * appConfig.factorSize
                            : mq.height * appConfig.factorSize,
                        fontWeight: FontWeight.bold,
                        color: prefs.highContrast
                            ? Colors.white
                            : const Color(0xFF003A70),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        ref.read(configProvider.notifier).setRate(-0.05);
                      },
                      borderRadius: BorderRadius.circular(500),
                      child: Container(
                        alignment: Alignment.center,
                        width: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        height: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: appConfig.ttsRate > 0.05
                              ? prefs.highContrast
                                  ? Colors.white
                                  : const Color(0xFF003A70)
                              : prefs.highContrast
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          color:
                              prefs.highContrast ? Colors.black : Colors.white,
                          size: orientation == Orientation.portrait
                              ? mq.width * 0.06
                              : mq.height * 0.06,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: orientation == Orientation.portrait
                          ? mq.width * 0.3
                          : mq.height * 0.3,
                      child: Text(
                        '${(appConfig.ttsRate * 100).round()}',
                        style: TextStyle(
                          fontSize: orientation == Orientation.portrait
                              ? mq.width * appConfig.factorSize
                              : mq.height * appConfig.factorSize,
                          fontWeight: FontWeight.normal,
                          color: prefs.highContrast
                              ? Colors.white
                              : const Color(0xFF003A70),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ref.read(configProvider.notifier).setRate(0.05);
                      },
                      borderRadius: BorderRadius.circular(500),
                      child: Container(
                        alignment: Alignment.center,
                        width: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        height: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: appConfig.ttsRate < 1
                              ? prefs.highContrast
                                  ? Colors.white
                                  : const Color(0xFF003A70)
                              : prefs.highContrast
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color:
                              prefs.highContrast ? Colors.black : Colors.white,
                          size: orientation == Orientation.portrait
                              ? mq.width * 0.06
                              : mq.height * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: orientation == Orientation.portrait
                    ? mq.width * 0.04
                    : mq.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Tono',
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * appConfig.factorSize
                            : mq.height * appConfig.factorSize,
                        fontWeight: FontWeight.bold,
                        color: prefs.highContrast
                            ? Colors.white
                            : const Color(0xFF003A70),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        ref.read(configProvider.notifier).setPitch(-0.05);
                      },
                      borderRadius: BorderRadius.circular(500),
                      child: Container(
                        alignment: Alignment.center,
                        width: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        height: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: appConfig.ttsPitch > 0.05
                              ? prefs.highContrast
                                  ? Colors.white
                                  : const Color(0xFF003A70)
                              : prefs.highContrast
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          color:
                              prefs.highContrast ? Colors.black : Colors.white,
                          size: orientation == Orientation.portrait
                              ? mq.width * 0.06
                              : mq.height * 0.06,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: orientation == Orientation.portrait
                          ? mq.width * 0.3
                          : mq.height * 0.3,
                      child: Text(
                        '${(appConfig.ttsPitch * 100).round()}',
                        style: TextStyle(
                          fontSize: orientation == Orientation.portrait
                              ? mq.width * appConfig.factorSize
                              : mq.height * appConfig.factorSize,
                          fontWeight: FontWeight.normal,
                          color: prefs.highContrast
                              ? Colors.white
                              : const Color(0xFF003A70),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ref.read(configProvider.notifier).setPitch(0.05);
                      },
                      borderRadius: BorderRadius.circular(500),
                      child: Container(
                        alignment: Alignment.center,
                        width: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        height: orientation == Orientation.portrait
                            ? mq.width * 0.1
                            : mq.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: appConfig.ttsPitch < 1
                              ? prefs.highContrast
                                  ? Colors.white
                                  : const Color(0xFF003A70)
                              : prefs.highContrast
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color:
                              prefs.highContrast ? Colors.black : Colors.white,
                          size: orientation == Orientation.portrait
                              ? mq.width * 0.06
                              : mq.height * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: orientation == Orientation.portrait
                    ? mq.width * 0.04
                    : mq.height * 0.04,
              ),
              Container(
                alignment: Alignment.center,
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  color: prefs.highContrast ? Colors.white : Colors.blue,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      alignment: Alignment.center,
                      width: orientation == Orientation.portrait
                          ? mq.width * 0.6
                          : mq.height * 0.6,
                      height: orientation == Orientation.portrait
                          ? mq.width * 0.2
                          : mq.height * 0.2,
                      child: Text(
                        'Probar voz'.toUpperCase(),
                        style: TextStyle(
                          fontSize: orientation == Orientation.portrait
                              ? mq.width * 0.68 * appConfig.factorSize
                              : mq.height * 0.68 * appConfig.factorSize,
                          fontWeight: FontWeight.bold,
                          color:
                              prefs.highContrast ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      ref
                          .read(appTTSProvider.notifier)
                          .speak('Esto es una prueba de voz');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  children: [
                    Text(
                      'Modo editor',
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * appConfig.factorSize
                            : mq.height * appConfig.factorSize,
                        fontWeight: FontWeight.bold,
                        color: prefs.highContrast
                            ? Colors.white
                            : const Color(0xFF003A70),
                      ),
                    ),
                    SizedBox(
                      height: orientation == Orientation.portrait
                          ? mq.width * 0.04
                          : mq.height * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: appConfig.editMode
                              ? prefs.highContrast
                                  ? Colors.white
                                  : Colors.blue
                              : prefs.highContrast
                                  ? Colors.transparent
                                  : Colors.grey[400],
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(configProvider.notifier)
                                  .setEditMode(true);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: prefs.highContrast ? 2 : 0,
                                      color: Colors.white)),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Text(
                                'Habilitado',
                                style: TextStyle(
                                  color: appConfig.editMode
                                      ? prefs.highContrast
                                          ? Colors.black
                                          : Colors.white
                                      : Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? mq.width * appConfig.factorSize
                                      : mq.height * appConfig.factorSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? mq.width * 0.02
                              : mq.height * 0.02,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: !appConfig.editMode
                              ? prefs.highContrast
                                  ? Colors.white
                                  : Colors.blue
                              : prefs.highContrast
                                  ? Colors.transparent
                                  : Colors.grey[400],
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(configProvider.notifier)
                                  .setEditMode(false);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: prefs.highContrast ? 2 : 0,
                                      color: Colors.white)),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Text(
                                'Deshabilitado',
                                style: TextStyle(
                                  color: !appConfig.editMode
                                      ? prefs.highContrast
                                          ? Colors.black
                                          : Colors.white
                                      : Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? mq.width * appConfig.factorSize
                                      : mq.height * appConfig.factorSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Tamaño de texto',
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * appConfig.factorSize
                            : mq.height * appConfig.factorSize,
                        fontWeight: FontWeight.bold,
                        color: prefs.highContrast
                            ? Colors.white
                            : const Color(0xFF003A70),
                      ),
                    ),
                    SizedBox(
                      height: orientation == Orientation.portrait
                          ? mq.width * 0.04
                          : mq.height * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: appConfig.factorText == 'pequeño'
                              ? prefs.highContrast
                                  ? Colors.white
                                  : Colors.blue
                              : prefs.highContrast
                                  ? Colors.transparent
                                  : Colors.grey[400],
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(configProvider.notifier)
                                  .setFactorSize(mq.width, 'pequeño');
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: prefs.highContrast ? 2 : 0,
                                      color: Colors.white)),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Text(
                                'Pequeño',
                                style: TextStyle(
                                  color: appConfig.factorText == 'pequeño'
                                      ? prefs.highContrast
                                          ? Colors.black
                                          : Colors.white
                                      : Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? mq.width * appConfig.factorSize
                                      : mq.height * appConfig.factorSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? mq.width * 0.02
                              : mq.height * 0.02,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: appConfig.factorText == 'predeterminado'
                              ? prefs.highContrast
                                  ? Colors.white
                                  : Colors.blue
                              : prefs.highContrast
                                  ? Colors.transparent
                                  : Colors.grey[400],
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(configProvider.notifier)
                                  .setFactorSize(mq.width, 'predeterminado');
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: prefs.highContrast ? 2 : 0,
                                      color: Colors.white)),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Text(
                                'Predeterminado',
                                style: TextStyle(
                                  color:
                                      appConfig.factorText == 'predeterminado'
                                          ? prefs.highContrast
                                              ? Colors.black
                                              : Colors.white
                                          : Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? mq.width * appConfig.factorSize
                                      : mq.height * appConfig.factorSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? mq.width * 0.02
                              : mq.height * 0.02,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: appConfig.factorText == 'grande'
                              ? prefs.highContrast
                                  ? Colors.white
                                  : Colors.blue
                              : prefs.highContrast
                                  ? Colors.transparent
                                  : Colors.grey[400],
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(configProvider.notifier)
                                  .setFactorSize(mq.width, 'grande');
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: prefs.highContrast ? 2 : 0,
                                      color: Colors.white)),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Text(
                                'Grande',
                                style: TextStyle(
                                  color: appConfig.factorText == 'grande'
                                      ? prefs.highContrast
                                          ? Colors.black
                                          : Colors.white
                                      : Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? mq.width * appConfig.factorSize
                                      : mq.height * appConfig.factorSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Diseño de pantalla',
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * appConfig.factorSize
                            : mq.height * appConfig.factorSize,
                        fontWeight: FontWeight.bold,
                        color: prefs.highContrast
                            ? Colors.white
                            : const Color(0xFF003A70),
                      ),
                    ),
                    SizedBox(
                      height: orientation == Orientation.portrait
                          ? mq.width * 0.04
                          : mq.height * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: appConfig.highContrast
                              ? prefs.highContrast
                                  ? Colors.transparent
                                  : Colors.grey[400]
                              : prefs.highContrast
                                  ? Colors.white
                                  : Colors.blue,
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(configProvider.notifier)
                                  .setHighContrast(false);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: prefs.highContrast ? 2 : 0,
                                      color: Colors.white)),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Text(
                                'Predeterminado',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? mq.width * appConfig.factorSize
                                      : mq.height * appConfig.factorSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? mq.width * 0.02
                              : mq.height * 0.02,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: appConfig.highContrast
                              ? prefs.highContrast
                                  ? Colors.white
                                  : Colors.blue
                              : prefs.highContrast
                                  ? Colors.transparent
                                  : Colors.grey[400],
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(configProvider.notifier)
                                  .setHighContrast(true);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      width: prefs.highContrast ? 2 : 0,
                                      color: Colors.white)),
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Text(
                                'Alto contraste',
                                style: TextStyle(
                                  color: prefs.highContrast
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? mq.width * appConfig.factorSize
                                      : mq.height * appConfig.factorSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: orientation == Orientation.portrait
                    ? mq.width * 0.08
                    : mq.height * 0.08,
              ),
              Material(
                borderRadius: BorderRadius.circular(16),
                color: appConfig.highContrast ? Colors.white : Colors.grey[400],
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: prefs.highContrast ? 2 : 0,
                            color: Colors.transparent)),
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                      'Exportar rutas',
                      style: TextStyle(
                        color: appConfig.highContrast
                            ? Colors.black
                            : Colors.white,
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * appConfig.factorSize
                            : mq.height * appConfig.factorSize,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: orientation == Orientation.portrait
                    ? mq.width * 0.02
                    : mq.height * 0.02,
              ),
              Material(
                borderRadius: BorderRadius.circular(16),
                color: appConfig.highContrast ? Colors.pink : Colors.red,
                child: InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Eliminar rutas'),
                      content: const Text(
                          '¿Estás seguro que deseas eliminar todas las rutas? Esta acción no se podrá deshacer.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancelar'),
                          child: const Text('CANCELAR'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Eliminar');
                            ref
                                .read(tARoutesProvider.notifier)
                                .deleteAllCards();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Se eliminaron todas las rutas.'),
                              ),
                            );
                          },
                          child: const Text('ELIMINAR'),
                        ),
                      ],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            width: prefs.highContrast ? 2 : 0,
                            color: Colors.transparent)),
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                      'Eliminar rutas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * appConfig.factorSize
                            : mq.height * appConfig.factorSize,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: orientation == Orientation.portrait
                    ? mq.width * 0.08
                    : mq.height * 0.08,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Desarrollado por'.toUpperCase(),
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * 0.6 * appConfig.factorSize
                            : mq.height * 0.6 * appConfig.factorSize,
                        color: prefs.highContrast
                            ? Colors.white
                            : const Color(0xFF003A70),
                      ),
                    ),
                    SizedBox(
                      height: orientation == Orientation.portrait
                          ? mq.width * 0.02
                          : mq.height * 0.02,
                    ),
                    Text(
                      'Clínica de Tecnología Asistiva, FLENI',
                      style: TextStyle(
                        fontSize: orientation == Orientation.portrait
                            ? mq.width * 0.8 * appConfig.factorSize
                            : mq.height * 0.8 * appConfig.factorSize,
                        color: prefs.highContrast
                            ? Colors.white
                            : const Color(0xFF003A70),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: orientation == Orientation.portrait
                          ? mq.width * 0.08
                          : mq.height * 0.08,
                    ),
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'https',
                          host: 'fleni.org.ar',
                          path: '/',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Image.asset(
                        appConfig.highContrast
                            ? 'assets/images/fleni-logo-h.png'
                            : 'assets/images/fleni-logo.png',
                        width: orientation == Orientation.portrait
                            ? mq.width * 0.6
                            : mq.height * 0.6,
                      ),
                    ),
                    SizedBox(
                      height: orientation == Orientation.portrait
                          ? mq.width * 0.08
                          : mq.height * 0.08,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
