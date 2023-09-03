import 'package:app_kaike_barbearia/app/template/filter_list_payment.dart';
import 'package:flutter/material.dart';

Future<String?> showFilterDialog(BuildContext context, String optionSelected) async {
  String option = optionSelected;
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Filtrar"),
        content: FilterListPayment(onGetOption: (value) => option = value, optionSelected: optionSelected,),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(option);
              },
            ),
          ),
        ],
      );
    },
  );
}
