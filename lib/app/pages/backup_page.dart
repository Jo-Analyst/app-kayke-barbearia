import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';

class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> backupDatabase() async {
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String dbPath = join(appDocumentsDirectory.path, "kaikebarbearia.db");
      File dbFile = File(dbPath);

      // Escolha um local para salvar o backup dentro do diretório de documentos
      String backupPath =
          join(appDocumentsDirectory.path, "my_database_backup.db");

      try {
        await dbFile.copy(backupPath);
        print("Backup criado com sucesso em $backupPath");
      } catch (e) {
        print("Erro ao criar backup: $e");
      }
    }

    bool isPermissionRequesting =
        false; // Variável para controlar o estado da solicitação de permissão

    Future<void> requestStoragePermission() async {
      if (!isPermissionRequesting) {
        // Verifique se uma solicitação já está em andamento
        isPermissionRequesting = true; // Defina o estado como true
        final status = await Permission.storage.request();
        isPermissionRequesting =
            false; // Defina o estado como false após a conclusão da solicitação
        if (status.isGranted) {
          backupDatabase();
        } else {
          // Trate o caso de permissão negada
        }
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Backup e restauração")),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Escolha o local do backup"),
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.file_copy))
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () => requestStoragePermission(),
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
                  onPressed: () {},
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
