import 'package:app_kaike_barbearia/app/pages/expense_form_page.dart';
import 'package:app_kaike_barbearia/app/pages/personal_expense_form_page.dart';
import 'package:app_kaike_barbearia/app/utils/content_message.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:app_kaike_barbearia/app/utils/dialog.dart';
import 'package:app_kaike_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../utils/convert_datetime.dart';

class PersonalExpenseListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const PersonalExpenseListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<PersonalExpenseListPage> createState() => _PersonalExpenseListPageState();
}

class _PersonalExpenseListPageState extends State<PersonalExpenseListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false;
  final List<Map<String, dynamic>> expenses = [
    {
      "id": 1,
      "name_product": "Gel Azul",
      "price": 20.00,
      "quantity": 10,
      "date": "07/10/2022"
    },
    {
      "id": 1,
      "name_product": "Gel preto",
      "price": 20.00,
      "quantity": 10,
      "date": "07/10/2022"
    },
    {
      "id": 1,
      "name_product": "Maquina de barbear",
      "price": 100.00,
      "quantity": 10,
      "date": "07/07/2023"
    },
  ];

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas pessoais"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PersonalExpenseFormPage(
                    isEdition: false,
                  ),
                ),
              ),
              icon: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: expenses.isEmpty
          ? const Center(
              child: Text(
                "Não há gastos cadastradoss...",
                style: TextStyle(fontSize: 20),
              ),
            )
          : Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Digite para buscar",
                      suffixIcon: search.isEmpty
                          ? const Icon(
                              Icons.search,
                            )
                          : IconButton(
                              onPressed: () {
                                searchController.text = "";
                                setState(() {
                                  search = "";
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (_, index) {
                        var speding = expenses[index];

                        return Column(
                          children: [
                            Slidable(
                              endActionPane: widget.itFromTheSalesScreen
                                  ? null
                                  : ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (_) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => SpedingFormPage(
                                                  isEdition: true,
                                                  spedingId: speding["id"],
                                                  nameProduct:
                                                      speding["name_product"],
                                                  price: speding["price"],
                                                  quantity: speding["quantity"],
                                                  date: getDateSpedings(
                                                      speding["date"]),
                                                  observation:
                                                      speding["observation"],
                                                ),
                                              ),
                                            );
                                          },
                                          backgroundColor: Colors.amber,
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit_outlined,
                                          label: "Editar",
                                        ),
                                        SlidableAction(
                                          onPressed: (_) async {
                                            final confirmDelete =
                                                await showExitDialog(context,
                                                    "Deseja mesmo excluir?");
                                            if (confirmDelete!) {
                                              expenses.removeAt(index);
                                              setState(() {});
                                              showMessage(
                                                const ContentMessage(
                                                  title:
                                                      "Excluido com sucesso.",
                                                  icon: Icons.info,
                                                ),
                                                const Color.fromARGB(
                                                    255, 199, 82, 74),
                                              );
                                            }
                                          },
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete,
                                          label: "Excluir",
                                        ),
                                      ],
                                    ),
                              child: ListTile(
                                selectedTileColor: Colors.indigo,
                                title: Text(
                                  speding["name_product"],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                subtitle: Text(
                                  dateFormat3
                                      .format(getDateSpedings(speding["date"])),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                trailing: Text(
                                  "${speding["quantity"]}x",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                leading: CircleAvatar(
                                  maxRadius: 40,
                                  backgroundColor: Colors.indigo,
                                  foregroundColor: Colors.white,
                                  child: Text(
                                    numberFormat.format(speding["price"]),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
