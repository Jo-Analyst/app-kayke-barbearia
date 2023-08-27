import 'package:flutter/material.dart';

class Message {
  static showMessage(
      BuildContext context, Widget content, Color? backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor ?? const Color.fromARGB(28, 0, 0, 0),
        duration: const Duration(milliseconds: 3000),
      ),
    );
  }
}
