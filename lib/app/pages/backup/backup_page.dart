import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/permission_use_app.dart';
import 'package:app_kayke_barbearia/app/utils/share.dart';
import 'package:app_kayke_barbearia/app/utils/show_message.dart';
import 'package:flutter/material.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  bool isLoadingBackup = false, isLoadingRestore = false;
  final selectedDirectory = TextEditingController();

  Future<void> toGenerateBackup() async {
    if (!await isGranted()) return;

    isLoadingBackup = true;

    setState(() {});
    final response = await Backup.toGenerate();
    isLoadingBackup = false;
    setState(() {});

    if (response != null) {
      showToast(
          message:
              "Houve um problema ao realizar o backup. Tente novamente. Caso o problema persista, acione o suporte.",
          isError: true,);

      return;
    }

    showToast(
      message: ''
          "Backup foi realizado com sucesso.",
    );

    await Future.delayed(const Duration(seconds: 7));

    ShareUtils.share();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Backup"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.backup,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const Text(
                "Para a segurança do seu sistema, gere o backup para uma futura restauração.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
              ),
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
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 10),
              //   child: ElevatedButton(
              //     onPressed: () => {},
              //     child: Container(
              //       width: double.infinity,
              //       alignment: Alignment.center,
              //       padding: const EdgeInsets.all(10),
              //       child: isLoadingRestore
              //           ? loadingFourRotatingDots(context, 20)
              //           : const Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Icon(Icons.restore),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   "Restauração",
              //                   style: TextStyle(fontSize: 20),
              //                 )
              //               ],
              //             ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
