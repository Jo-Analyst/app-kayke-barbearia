import 'package:app_kaike_barbearia/app/template/filter_list_payment.dart';
import 'package:flutter/material.dart';

Future<bool?> showFilterDialog(BuildContext context) async {
  
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Filtrar"),
        content: const FilterListPayment(),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              child: const Text("OK"),
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
