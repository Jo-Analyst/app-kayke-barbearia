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
  List<String> names = [];
  List<String> phones = [];
  List<Map<String, dynamic>> listContact = [];

  Future<void> _fetchContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.toList();
      isLoading = false;
    });

    for (int i = 0; i < contacts.toList().length; i++) {
      listContact.add(
        {
          "name": contacts.toList()[i].displayName,
        },
      );
      final phones = contacts.toList()[i].phones!;
      for (var phone in phones) {
        listContact[i]["phone"] = phone.value;
      }
    }
    print(listContact);
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
              onPressed: phones.isNotEmpty
                  ? () {
                      List<Map<String, dynamic>> data = [];
                      int index = 0;
                      for (var phone in phones) {
                        data.add({"name": names[index], "phone": phone});
                        index++;
                      }

                      Navigator.of(context).pop(data);
                    }
                  : null,
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: isLoading
          ? const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(
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
                              names.contains(contact.displayName)
                                  ? names.remove(contact.displayName!)
                                  : names.add(contact.displayName!);

                              phones.contains(contact.phones![0].value)
                                  ? phones.remove(contact.phones![0].value)
                                  : phones
                                      .add(contact.phones![0].value.toString());
                            });
                          },
                          selected: names.contains(contact.displayName),
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
                            backgroundColor: names.contains(contact.displayName)
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            foregroundColor: names.contains(contact.displayName)
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            child: Text(
                              contact.displayName.toString().split("")[0],
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
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
