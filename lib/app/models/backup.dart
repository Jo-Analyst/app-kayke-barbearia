import 'dart:io';

class Backup {
  static String path = "";
  static Future<String?> toGenerate() async {
    DateTime dt = DateTime.now();
    List<int> date = [dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second];
    String joinDateString =
        "${date[2].toString().padLeft(2, "0")}-${date[1].toString().padLeft(2, "0")}-${date[0]}T${date[3].toString().padLeft(2, "0")}:${date[4].toString().padLeft(2, "0")}:${date[5].toString().padLeft(2, "0")}";
    path = '/storage/emulated/0/App Kayke Barbearia/$joinDateString';
    try {
      File ourDbFile = File(
          "/data/user/0/com.example.app_kayke_barbearia/databases/appkaykebarbearia.db");

      Directory? folderPathForDbFile = Directory(path);
      await folderPathForDbFile.create();
      await ourDbFile.copy("$path/appkaykebarbearia.db");
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  static Future<String?> restore() async {
    try {
      File saveDBFile = File("$path/appkaykebarbearia.db");

      await saveDBFile.copy(
          "/data/user/0/com.example.app_kayke_barbearia/databases/appkaykebarbearia.db");
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
