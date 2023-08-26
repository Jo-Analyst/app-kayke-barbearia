import 'package:app_kaike_barbearia/app/pages/client_form_page.dart';
import 'package:app_kaike_barbearia/app/pages/contact_phone_page.dart';
import 'package:app_kaike_barbearia/app/utils/dialog.dart';
import 'package:app_kaike_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final List<Map<String, dynamic>> clients = [
    {"id": 1, "name": "Juliana Andrade", "phone": "38998269905"},
    {"id": 2, "name": "Carlos da Silva Xavier", "phone": "38999093710"},
    {"id": 3, "name": "Maria Francisca santos", "phone": "38998269905"},
    {"id": 4, "name": "Lucimara Cristina Pereira", "phone": "38998269905"},
    {"id": 5, "name": "Alberto Rodrigues", "phone": "38998269905"},
    {"id": 1, "name": "Juliana Andrade", "phone": "38998269905"},
    {"id": 2, "name": "Carlos da Silva Xavier", "phone": "38999093710"},
    {"id": 3, "name": "Maria Francisca santos", "phone": "38998269905"},
    {"id": 4, "name": "Lucimara Cristina Pereira", "phone": "38998269905"},
    {"id": 5, "name": "Alberto Rodrigues", "phone": "38998269905"},
    {
      "id": 5,
      "name": "Zé Canália",
      "phone": "38998269905",
      "observation": "Tá me devendo pra dedel"
    },
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
    ConfirmationMessage.showMessage(context, content, color);
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
                      separatorBuilder: (_, index) {
                        return Divider(color: Theme.of(context).primaryColor);
                      },
                      itemCount: clients.length,
                      itemBuilder: (_, index) {
                        var client = clients[index];
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
                                            builder: (_) => ClientFormPage(
                                              clientId: client["id"],
                                              name: client["name"],
                                              phone: client["phone"],
                                              observation:
                                                  client["observation"],
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
                                        final confirmDelete = await showExitDialog(
                                            context,
                                            "Deseja mesmo excluir o(a) cliente '${client["name"]}'?");
                                        if (confirmDelete!) {
                                          clients.removeAt(index);
                                          setState(() {});
                                          showMessage(
                                            const Row(
                                              children: [
                                                Icon(Icons.info),
                                                SizedBox(width: 5),
                                                Text(
                                                  "Cliente excluido com sucesso.",
                                                ),
                                              ],
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
                            subtitle: Text(client["phone"]),
                            leading: CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              child: Text(
                                client["name"].toString().split("")[0],
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
