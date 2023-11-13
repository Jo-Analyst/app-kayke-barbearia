import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/permission_use_app.dart';
import 'package:app_kayke_barbearia/app/utils/share.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool isLoadingBackup = false, isLoadingRestore = false;
  final selectedDirectory = TextEditingController();

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 7000);
  }

  void restore() async {
    if (!await isGranted()) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath = result.files.single.path ?? '';
      int filePathLength = filePath.split(".").length;
      String extension = filePath.split(".")[filePathLength - 1];
      if (extension != "db") {
        showMessage(
          const ContentMessage(
            title: "Arquivo de backup inválido!",
            icon: Icons.error,
          ),
          Colors.red,
        );

        return;
      }

      isLoadingRestore = true;
      setState(() {});

      final response = await Backup.restore(filePath);
      isLoadingRestore = false;
      setState(() {});
      if (response != null) {
        showMessage(
          const ContentMessage(
            title:
                "Houve um problema ao realizar a restauração. Verifique se há arquivo de backup no caminho predefinido pelo app e tente novamente. Caso o problema persista, acione o suporte.",
            icon: Icons.error,
          ),
          Colors.orange,
        );

        return;
      }

      showMessage(
        const ContentMessage(
          title: "A restauração foi realizada com sucesso.",
          icon: Icons.info,
        ),
        null,
      );
    }
  }

  Future<bool> isGranted() async {
    bool isGrantedPermission = true;
    if (!await isGrantedRequestPermissionStorage()) {
      openAppSettings();
      isGrantedPermission = false;
    }

    return isGrantedPermission;
  }

  Future<void> toGenerateBackup() async {
    if (!await isGranted()) return;

    isLoadingBackup = true;

    setState(() {});
    final response = await Backup.toGenerate();
    isLoadingBackup = false;
    setState(() {});

    if (response != null) {
      showMessage(
        const ContentMessage(
          title:
              "Houve um problema ao realizar o backup. Tente novamente. Caso o problema persista, acione o suporte.",
          icon: Icons.error,
        ),
        Colors.orange,
      );

      return;
    }

    showMessage(
      const ContentMessage(
        title: "Backup foi realizado com sucesso.",
        icon: Icons.info,
      ),
      null,
    );

    ShareUtils.share();
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
                    await toGenerateBackup();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: isLoadingBackup
                        ? loadingFourRotatingDots(context, 20)
                        : const Row(
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
                  onPressed: () => restore(),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: isLoadingRestore
                        ? loadingFourRotatingDots(context, 20)
                        : const Row(
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
