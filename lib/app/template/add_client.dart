import 'package:app_kaike_barbearia/app/pages/client_form_page.dart';
import 'package:flutter/material.dart';

class AddNewClient extends StatelessWidget {
  const AddNewClient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Cadastro de clientes",
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
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ClientFormPage(),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Adicionar Cliente",
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
