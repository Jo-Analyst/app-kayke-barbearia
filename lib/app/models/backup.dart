import 'dart:io';

class Backup {
  static String pathStorage = '/storage/emulated/0/App Kayke Barbearia';
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

  static Future<String?> restore() async {
    try {
      File saveDBFile = File("$pathStorage/appkaykebarbearia.db");

      await saveDBFile.copy(pathDB);
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
