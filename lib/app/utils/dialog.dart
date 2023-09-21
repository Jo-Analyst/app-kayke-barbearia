import 'package:flutter/material.dart';

Future<bool?> showExitDialog(BuildContext context, String content) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Excluir",
          style: TextStyle(fontSize: 20),
        ),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text(
              'Cancelar',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              child: const Text(
                "Excluir",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ),
        ],
      );
    },
  );
}
