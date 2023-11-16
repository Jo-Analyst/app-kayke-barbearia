import 'dart:io';

import 'package:app_kayke_barbearia/app/utils/path.dart';



class Backup {
  static String pathDB =
      '/data/user/0/com.example.app_kayke_barbearia/databases/appkaykebarbearia.db';

  static Future<String?> toGenerate() async {
    try {
      File ourDbFile = File(pathDB);

      Directory? folderPathForDbFile = Directory(pathStorage);
      await folderPathForDbFile.create();
      await ourDbFile.copy("$pathStorage/appkaykebarbearia.db");
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  static Future<String?> restore(String filePath) async {
    try {
      File saveDBFile = File(filePath);

      await saveDBFile.copy(pathDB);
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
