import 'package:app_kaike_barbearia/app/pages/service_form_page.dart';
import 'package:app_kaike_barbearia/app/utils/content_message.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:app_kaike_barbearia/app/utils/dialog.dart';
import 'package:app_kaike_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ServiceListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const ServiceListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false;
  final List<Map<String, dynamic>> services = [
    {"id": 1, "description": "Corte social", "price": 15.00},
    {"id": 1, "description": "pezinho", "price": 12.00},
    {"id": 1, "description": "barbear", "price": 13.00},
  ];

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serviços"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ServiceFormPage(
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
      body: services.isEmpty
          ? const Center(
              child: Text(
                "Não há serviço cadastrados...",
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
                          height: 2,
                        );
                      },
                      itemCount: services.length,
                      itemBuilder: (_, index) {
                        var service = services[index];
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
                                            builder: (_) => ServiceFormPage(
                                              isEdition: true,
                                              serviceId: service["id"],
                                              description:
                                                  service["description"],
                                              price: service["price"],
                                              observation:
                                                  service["observation"],
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
                                            "Deseja mesmo excluir o serviço '${service["description"]}'?");
                                        if (confirmDelete!) {
                                          services.removeAt(index);
                                          setState(() {});
                                          showMessage(
                                            const ContentMessage(
                                              title:
                                                  "Serviço excluido com sucesso.",
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
                            contentPadding: const EdgeInsets.all(5),
                            selectedTileColor: Colors.indigo,
                            title: Text(
                              service["description"],
                              style: const TextStyle(fontSize: 20),
                            ),
                            leading: CircleAvatar(
                              maxRadius: 40,
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              child: Text(
                                numberFormat.format(service["price"]),
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
