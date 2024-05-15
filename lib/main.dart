import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/app.dart';
import 'package:tarutas/src/data/local/local_db.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  final localDB = LocalData();
  await localDB.init();
  await localDB.openBox();
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(
    const ProviderScope(
      child: TARutas(),
    ),
  );
}
