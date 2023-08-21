import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactPhonePage extends StatefulWidget {
  const ContactPhonePage({super.key});

  @override
  State<ContactPhonePage> createState() => _ContactPhonePageState();
}

class _ContactPhonePageState extends State<ContactPhonePage> {
  final searchController = TextEditingController();
  bool isLoading = true;
  String search = "";
  List<Contact> _contacts = [];
  List<String> clients = [];

  Future<void> _fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.toList();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Importar Contatos"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                    child: ListView.separated(
                      separatorBuilder: (__, index) {
                        return Divider(
                          height: 1,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                      itemCount: _contacts.length,
                      itemBuilder: (_, index) {
                        var contact = _contacts[index];
                        return ListTile(
                          onLongPress: () {
                            setState(() {
                              clients.contains(contact.displayName)
                                  ? clients.remove(contact.displayName!)
                                  : clients.add(contact.displayName!);
                            });
                          },
                          selected: clients.contains(contact.displayName),
                          selectedTileColor: Colors.indigo,
                          selectedColor: Colors.white,
                          title: Text(contact.displayName ?? ""),
                          subtitle: Text(
                            contact.phones!
                                .map((phone) => phone.value)
                                .join('\n'),
                          ),
                          leading: CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            child: Text(
                              contact.displayName.toString().split("")[0],
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
