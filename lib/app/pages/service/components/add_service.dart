import 'package:flutter/material.dart';

import '../service_form_page.dart';

class AddNewService extends StatelessWidget {
  final Function()? closeKeyboard;
  const AddNewService({this.closeKeyboard, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Cadastro de Serviços",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              "Você ainda não tem cadastro",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                closeKeyboard!();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ServiceFormPage(isEdition: false),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Adicionar Serviço",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
