import 'package:share/share.dart';

class ShareUtils {
  static void share() {
    Share.shareFiles(
      ["/storage/emulated/0/App Kayke Barbearia/appkaykebarbearia.db"],
      text: "Backup concluído!",
    );
  }
}
