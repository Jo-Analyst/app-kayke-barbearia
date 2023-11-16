import 'package:app_kayke_barbearia/app/utils/path.dart';
import 'package:share/share.dart';

class ShareUtils {
  static void share() {
    Share.shareFiles(
      ["/$pathStorage/appkaykebarbearia.db"],
      text: "Backup concluído!",
    );
  }
}
