import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/app.dart';
import 'package:tarutas/src/data/local/local_db.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Bloqueo de orientacion para pantallas chicas
  //await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //if(getDeviceType() == 'phone'){
  //  SystemChrome.setPreferredOrientations([
  //     DeviceOrientation. portraitUp,
  //  ]);
  //      }
  // statusbar transparente
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  final prefs = UserPreferences();
  await prefs.initPrefs();
  final localDB = LocalData();
  await localDB.init();
  await localDB.openBox();
  runApp(
    const ProviderScope(
      child: TARutas(),
    ),
  );
}
