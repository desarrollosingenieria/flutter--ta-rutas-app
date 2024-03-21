import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de pitch
  double get pitch {
    return _prefs.getDouble('pitch') ?? 1.0;
  }

  set pitch(double value) {
    _prefs.setDouble('pitch', value);
  }

  // GET y SET de rate
  double get rate {
    return _prefs.getDouble('rate') ?? 0.5;
  }

  set rate(double value) {
    _prefs.setDouble('rate', value);
  }

  // GET y SET de volume
  double get volume {
    return _prefs.getDouble('volume') ?? 1.0;
  }

  set volume(double value) {
    _prefs.setDouble('volume', value);
  }

  // GET y SET de factorSize
  double get factorSize {
    return _prefs.getDouble('factorSize') ?? 0.04;
  }

  set factorSize(double factor) {
    _prefs.setDouble('factorSize', factor);
  }

  // GET y SET de cardStyle
  String get cardStyle {
    return _prefs.getString('cardStyle') ?? 'Texto e Imagen';
  }

  set cardStyle(String style) {
    _prefs.setString('cardStyle', style);
  }

  // GET y SET de factorSize
  String get factorText {
    return _prefs.getString('factorText') ?? 'predeterminado';
  }

  set factorText(String factor) {
    _prefs.setString('factorText', factor);
  }

  // GET y SET del modo de tema
  String get themeMode {
    return _prefs.getString('themeMode') ?? 'light';
  }

  set themeMode(String mode) {
    _prefs.setString('themeMode', mode);
  }

    // GET y SET del modo de tema
  bool get highContrast {
    return _prefs.getBool('highContrast') ?? false;
  }

  set highContrast(bool mode) {
    _prefs.setBool('highContrast', mode);
  }

  Future<bool> cleanPrefs() async {
    return _prefs.clear();
  }
}
