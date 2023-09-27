import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  final selectedDirectory = TextEditingController();

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  Future<void> requestPermissions() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    var status1 = await Permission.storage.status;

    if (!status1.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> performAction(Function() action, String? actionName) async {
    await requestPermissions();

    final response = await action();

    if (response != null) {
      showMessage(
        ContentMessage(
          title: actionName != null
              ? "Houve um problema ao realizar o backup. Tente novamente. Caso o problema persista, acione o suporte."
              : "Houve um problema ao realizar a restauração. Tente novamente. Caso o problema persista, acione o suporte.",
          icon: Icons.error,
        ),
        Colors.orange,
      );

      return;
    }

    showMessage(
      ContentMessage(
        title: actionName != null
            ? "A restauração foi realizada com sucesso."
            : "O backup foi realizado com sucesso.",
        icon: Icons.info,
      ),
      null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Backup e restauração"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    await performAction(Backup.toGenerate, null);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.backup),
                        SizedBox(width: 10),
                        Text(
                          "Backup",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    await performAction(Backup.restore, "restauração");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restore),
                        SizedBox(width: 10),
                        Text(
                          "Restauração",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
