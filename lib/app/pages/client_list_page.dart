import 'package:app_kayke_barbearia/app/pages/client_form_page.dart';
import 'package:app_kayke_barbearia/app/pages/contact_phone_page.dart';
import 'package:app_kayke_barbearia/app/providers/client_provider.dart';
import 'package:app_kayke_barbearia/app/template/add_client.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../utils/cache.dart';

class ClientListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const ClientListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  final searchController = TextEditingController();
  bool isLoading = true;
  String search = "";
  bool isGranted = false;
  List<Map<String, dynamic>> clients = [];

  Future<void> permissionGranted() async {
    var status = await Permission.contacts.request();
    setState(() {
      isGranted = status.isGranted;
    });
  }

  openScreenContacts() async {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ContactPhonePage(),
      ),
    );
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  @override
  void initState() {
    super.initState();
    clients.clear();
    loadClients();
  }

  loadClients() async {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    await clientProvider.load();
    setState(() {
      isLoading = false;
      clients = clientProvider.items;
    });
  }

  void deleteService(ClientProvider clientsProvider, client) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final confirmDelete = await showExitDialog(
        context, "Deseja mesmo excluir o(a) cliente '${client["name"]}'?");
    if (confirmDelete == true) {
      await clientsProvider.delete(client["id"]);
      showMessage(
        const ContentMessage(
          title: "Cliente excluido com sucesso.",
          icon: Icons.info,
        ),
        const Color.fromARGB(255, 199, 82, 74),
      );
    }
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
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ClientFormPage(
                      isEdition: false,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: loading(context, 50))
          : SingleChildScrollView(
              child: Consumer<ClientProvider>(
                builder: (context, clientsProvider, _) {
                  clients = clientsProvider.items;
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    height: MediaQuery.of(context).size.height - 140,
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          focusNode: textFocusNode,
                          textInputAction: TextInputAction.search,
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
                                        loadClients();
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              search = value;
                              clientsProvider.searchName(value);
                            });
                          },
                        ),
                        clients.isEmpty
                            ? Center(
                                child: AddNewClient(
                                  closeKeyboard: () =>
                                      FocusScope.of(context).requestFocus(
                                    FocusNode(),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: clients.length,
                                        itemBuilder: (_, index) {
                                          var client = clients[index];
                                          return Column(
                                            children: [
                                              Slidable(
                                                endActionPane: widget
                                                        .itFromTheSalesScreen
                                                    ? null
                                                    : ActionPane(
                                                        motion:
                                                            const StretchMotion(),
                                                        children: [
                                                          SlidableAction(
                                                            onPressed: (_) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      FocusNode());
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      ClientFormPage(
                                                                    isEdition:
                                                                        true,
                                                                    clientId:
                                                                        client[
                                                                            "id"],
                                                                    name: client[
                                                                        "name"],
                                                                    phone: client[
                                                                        "phone"],
                                                                    address: client[
                                                                        "address"],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            backgroundColor:
                                                                Colors.amber,
                                                            foregroundColor:
                                                                Colors.white,
                                                            icon: Icons
                                                                .edit_outlined,
                                                            label: "Editar",
                                                          ),
                                                          SlidableAction(
                                                            onPressed: (_) {
                                                              deleteService(
                                                                  clientsProvider,
                                                                  client);
                                                            },
                                                            backgroundColor:
                                                                Colors.red,
                                                            icon: Icons.delete,
                                                            label: "Excluir",
                                                          ),
                                                        ],
                                                      ),
                                                child: ListTile(
                                                  onTap: widget
                                                          .itFromTheSalesScreen
                                                      ? () {
                                                          Navigator.of(context)
                                                              .pop(client);
                                                        }
                                                      : null,
                                                  selectedTileColor:
                                                      Colors.indigo,
                                                  title: Text(client["name"]),
                                                  subtitle: Text(client["phone"]
                                                          .toString()
                                                          .isNotEmpty
                                                      ? client["phone"]
                                                      : "Sem número"),
                                                  leading: CircleAvatar(
                                                    maxRadius: 30,
                                                    backgroundColor:
                                                        Colors.indigo,
                                                    foregroundColor:
                                                        Colors.white,
                                                    child: Text(
                                                      client["name"]
                                                          .toString()
                                                          .split("")[0],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
