import 'dart:io';

import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/hotmail.dart';

class Mail {
  static Future<String?> sendEmailWithAttachment(String backupFilePath) async {
    final smtpServer = hotmail(dotenv.get("EMAIL"), dotenv.get("PASSWORD"));
    DateTime dt = DateTime.now();
    final message = Message()
      ..from = Address(dotenv.get("EMAIL"), 'APP Kayke Barbearia')
      ..recipients.add(dotenv.get("EMAIL"))
      ..ccRecipients.add(dotenv.get("EMAIL-SECUNDARY"))
      ..subject = 'Backup do APP Kayke Barbearia'
      ..text = 'Anexo de backup do banco de dados do APP Kayke Barbearia'
      ..attachments.add(FileAttachment(File(backupFilePath)))
      ..html =
          '<div><h1>Anexo de backup do banco de dados do APP Kayke Barbearia</h1>Backup realizado pelo aplicativo App Kayke Barbearia no dia ${dateFormat5.format(dt)}</div>';

    try {
      await send(message, smtpServer);
    } catch (e) {
      return e.toString();
    }

    return null;
  }
}
