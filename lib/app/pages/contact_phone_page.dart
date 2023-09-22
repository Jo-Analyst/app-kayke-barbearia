import 'package:app_kayke_barbearia/app/providers/client_provider.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/search_list.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:provider/provider.dart';

import '../utils/content_message.dart';
import '../utils/snackbar.dart';

class ContactPhonePage extends StatefulWidget {
  const ContactPhonePage({super.key});

  @override
  State<ContactPhonePage> createState() => _ContactPhonePageState();
}

class _ContactPhonePageState extends State<ContactPhonePage> {
  final searchController = TextEditingController();
  bool isLoading = true, selectedEverything = false;
  String search = "";
  final List<Map<String, dynamic>> _contacts = [];
  List<String> names = [];
  List<String> phones = [];
  List<Map<String, dynamic>> filteredList = [];

  Future<void> _fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      for (int i = 0; i < contacts.toList().length; i++) {
        _contacts.add(
          {
            "name": contacts.toList()[i].displayName,
          },
        );
        final phones = contacts.toList()[i].phones!;
        for (var phone in phones) {
          _contacts[i]["phone"] = phone.value;
        }
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts();
    filteredList = _contacts;
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  void importContacts() {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);

    int index = 0;
    for (var phone in phones) {
      clientProvider
          .save({"id": 0, "name": names[index], "phone": phone, "address": ""});
      index++;
    }
    showMessage(
      const ContentMessage(
        title: "Cliente importado com sucesso.",
        icon: Icons.info,
      ),
      null,
    );
    Navigator.of(context).pop();
  }

  void selectContact(Map<String, dynamic> contact) {
    setState(() {
      names.contains(contact["name"])
          ? names.remove(contact["name"])
          : names.add(contact["name"] ?? "Sem nome");

      phones.contains(contact["phone"])
          ? phones.remove(contact["phone"])
          : phones.add(contact["phone"] ?? "Sem número");
    });
  }

  void clearLists() {
    setState(() {
      names.clear();
      phones.clear();
    });
  }

  selectAll() {
    if (selectedEverything) {
      clearLists();
      setState(() {
        selectedEverything = false;
      });
      return;
    }

    clearLists();
    setState(() {
      for (var contact in _contacts) {
        names.add(contact["name"] ?? "Sem nome");
        phones.add(contact["phone"] ?? "Sem número");
      }

      selectedEverything = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            names.isNotEmpty ? names.length.toString() : "Importar Contatos"),
        actions: [
          IconButton(
            onPressed: phones.isNotEmpty ? () => importContacts() : null,
            icon: Visibility(
              visible: names.isNotEmpty,
              child: IconButton(
                onPressed: () => selectAll(),
                icon: const Icon(
                  Icons.select_all,
                  size: 30,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: phones.isNotEmpty
                ? IconButton(
                    onPressed: () => importContacts(),
                    icon: const Icon(
                      Icons.check,
                      size: 30,
                    ),
                  )
                : null,
          )
        ],
      ),
      body: isLoading
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  loading(context, 50),
                  const Text(
                    "Carregando...",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
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
                                  filteredList = _contacts;
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        search = value;
                        filteredList = searchItems(value, _contacts, "name");
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (_, index) {
                        var contact = filteredList[index];
                        return Column(
                          children: [
                            ListTile(
                              onLongPress: () {
                                selectContact(contact);
                              },
                              onTap: () {
                                if (names.isEmpty) {
                                  importContacts();
                                  return;
                                }
                                selectContact(contact);
                              },
                              selected: names.contains(contact["name"]),
                              selectedTileColor: Colors.indigo,
                              selectedColor: Colors.white,
                              title: Text(contact["name"] ?? "Sem nome"),
                              subtitle: Text(
                                contact["phone"] ?? "Sem número",
                              ),
                              leading: CircleAvatar(
                                maxRadius: 25,
                                backgroundColor: names.contains(contact["name"])
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                                foregroundColor: names.contains(contact["name"])
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                child: Text(
                                  contact["name"].toString().split("")[0],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
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
