import 'package:flutter/material.dart';

class Message {
  static showMessage(
      BuildContext context, Widget content, Color? backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor ?? const Color.fromARGB(255, 20, 20, 20),
        duration: const Duration(milliseconds: 3000),
      ),
    );
  }
}
