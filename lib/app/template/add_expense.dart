import 'package:app_kayke_barbearia/app/pages/expense_form_page.dart';
import 'package:flutter/material.dart';

class AddNewExpense extends StatelessWidget {
  final Function()? closeKeyboard;
  const AddNewExpense({this.closeKeyboard, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Cadastro de despesas",
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
                    builder: (_) => const ExpenseFormPage(isEdition: false),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Adicionar Despesa",
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
