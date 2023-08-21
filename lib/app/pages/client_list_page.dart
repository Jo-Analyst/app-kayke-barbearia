import 'package:app_kaike_barbearia/app/pages/client_form_page.dart';
import 'package:app_kaike_barbearia/app/pages/contact_phone_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false;
  final List<Map<String, dynamic>> clients = [
    {"name": "Juliana Andrade", "phone": "38998269905"},
    {"name": "Carlos da Silva Xavier", "phone": "38999093710"},
    {"name": "Maria Francisca santos", "phone": "38998269905"},
    {"name": "Lucimara Cristina Pereira", "phone": "38998269905"},
    {"name": "Alberto Rodrigues", "phone": "38998269905"},
  ];

  Future<void> permissionGranted() async {
    var status = await Permission.contacts.request();
    setState(() {
      isGranted = status.isGranted;
    });
  }

  openScreenContacts() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ContactPhonePage(),
      ),
    );
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
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
                itemCount: clients.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    selectedTileColor: Colors.indigo,
                    title: Text(clients[index]["name"]),
                    subtitle: Text(clients[index]["phone"]),
                    leading: CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Text(
                        clients[index]["name"].toString().split("")[0],
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
