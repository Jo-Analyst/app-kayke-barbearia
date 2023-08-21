import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientFormPage extends StatefulWidget {
  const ClientFormPage({super.key});

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final observationController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  String? _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cliente",
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _name!.isNotEmpty ? () {} : null,
              icon: const Icon(
                Icons.check,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 18,
        ),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              maxLength: 100,
              decoration: const InputDecoration(labelText: "nome"),
              style: const TextStyle(fontSize: 18),
              onChanged: (name) {
                setState(() {
                  _name = name;
                });
              },
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 11,
              decoration: const InputDecoration(labelText: "Cel/Tel"),
              style: const TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: observationController,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Observação"),
              style: const TextStyle(fontSize: 18),
              maxLength: 1000,
            ),
          ],
        ),
      ),
    );
  }
}
