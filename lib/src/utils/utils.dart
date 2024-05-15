import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> loadTemplates(String template) async {
  PlatformAssetBundle().load;
  final fleniByte = await PlatformAssetBundle().load(template);
  var applicationDocumentsDirectory = await getApplicationDocumentsDirectory();
  File file = File('${applicationDocumentsDirectory.path}/template-fleni.hive');
  await file.writeAsBytes(fleniByte.buffer
      .asUint8List(fleniByte.offsetInBytes, fleniByte.lengthInBytes));
  return file.path;
}
