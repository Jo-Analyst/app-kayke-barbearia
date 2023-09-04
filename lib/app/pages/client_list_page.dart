import 'package:app_kaike_barbearia/app/pages/client_form_page.dart';
import 'package:app_kaike_barbearia/app/pages/contact_phone_page.dart';
import 'package:app_kaike_barbearia/app/utils/content_message.dart';
import 'package:app_kaike_barbearia/app/utils/dialog.dart';
import 'package:app_kaike_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/search_list.dart';

class ClientListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const ClientListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false;
  List<Map<String, dynamic>> filteredList = [];
  final List<Map<String, dynamic>> clients = [
    {"id": 1, "name": "Valdirene Aparecida Ferreira", "phone": "38998269905"},
    {"id": 2, "name": "Joelmir Rogério Carvalho", "phone": "38999093710"},
    {"id": 3, "name": "Maria Lídia Ferrira Carvalho"},
    {"id": 4, "name": "Noelly Cristina Ferreira Carvalho"},
    {"id": 5, "name": "Antonny Benneditto Ferreira Carvalho"},
    {"id": 6, "name": "Juliana Andrade", "phone": "38998269905"},
    {"id": 7, "name": "Carlos da Silva Xavier", "phone": "38999093710"},
    {"id": 8, "name": "Maria Francisca santos", "phone": "38998269905"},
    {"id": 9, "name": "Lucimara Cristina Pereira", "phone": "38998269905"},
    {"id": 10, "name": "Alberto Rodrigues", "phone": "38998269905"},
  ];

  Future<void> permissionGranted() async {
    var status = await Permission.contacts.request();
    setState(() {
      isGranted = status.isGranted;
    });
  }

  openScreenContacts() async {
    final contact = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ContactPhonePage(),
      ),
    );

    if (contact != null) {
      setState(() {
        clients.addAll(contact);
      });
    }
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  @override
  void initState() {
    super.initState();
    filteredList = clients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        actions: [
          IconButton(
            onPressed: () async {
              await permissionGranted();
              if (!isGranted) return;

              openScreenContacts();
            },
            icon: const Icon(Icons.contacts),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ClientFormPage(),
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
      body: clients.isEmpty
          ? const Center(
              child: Text(
                "Não há clientes cadastrados...",
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
                                  filteredList = clients;
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        search = value;
                        filteredList = searchItems(value, clients, false);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (_, index) {
                        var client = filteredList[index];
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
                                                builder: (_) => ClientFormPage(
                                                  clientId: client["id"],
                                                  name: client["name"],
                                                  phone: client["phone"],
                                                  address:
                                                      client["address"],
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
                                                    "Deseja mesmo excluir o(a) cliente '${client["name"]}'?");
                                            if (confirmDelete!) {
                                              clients.removeAt(index);
                                              setState(() {});
                                              showMessage(
                                                const ContentMessage(
                                                  title:
                                                      "Cliente excluido com sucesso.",
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
                                onTap: widget.itFromTheSalesScreen
                                    ? () {
                                        Navigator.of(context).pop(client);
                                      }
                                    : null,
                                selectedTileColor: Colors.indigo,
                                title: Text(client["name"]),
                                subtitle: Text(client["phone"] ?? "Sem número"),
                                leading: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor: Colors.indigo,
                                  foregroundColor: Colors.white,
                                  child: Text(
                                    client["name"].toString().split("")[0],
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
