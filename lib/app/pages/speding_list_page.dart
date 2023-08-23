import 'package:app_kaike_barbearia/app/pages/speding.form_page.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:app_kaike_barbearia/app/utils/dialog.dart';
import 'package:app_kaike_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../utils/convert_datetime.dart';

class SpedingListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const SpedingListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<SpedingListPage> createState() => _SpedingListPageState();
}

class _SpedingListPageState extends State<SpedingListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false;
  final List<Map<String, dynamic>> spedings = [
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

  void showMessage(String content, Color? color) {
    ConfirmationMessage.showMessage(context, content, color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SpedingFormPage(
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
      body: spedings.isEmpty
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
                    child: ListView.separated(
                      separatorBuilder: (__, _) {
                        return Divider(
                          color: Theme.of(context).primaryColor,
                        );
                      },
                      itemCount: spedings.length,
                      itemBuilder: (_, index) {
                        var speding = spedings[index];

                        return Slidable(
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
                                          spedings.removeAt(index);
                                          setState(() {});
                                          showMessage(
                                              "Excluido com sucesso.",
                                              const Color.fromARGB(
                                                  255, 199, 82, 74));
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
