import 'package:flutter/material.dart';

class ConfirmationMessage {
  static showMessage(BuildContext context, String content, Color? backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor ?? const Color.fromARGB(28, 0, 0, 0),
        duration: const Duration(milliseconds: 3000),
      ),
    );
  }
}