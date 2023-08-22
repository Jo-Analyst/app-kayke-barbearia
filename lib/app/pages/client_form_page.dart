import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientFormPage extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? observation;
  final int? clientId;

  const ClientFormPage({
    this.clientId,
    this.name,
    this.phone,
    this.observation,
    super.key,
  });

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
  void initState() {
    super.initState();

    if (widget.clientId == 0) return;
    _name = widget.name;
    nameController.text = _name ?? "";
    phoneController.text = widget.phone ?? "";
    observationController.text = widget.observation ?? "";
  }

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
              onPressed: _name == null || _name!.trim() == "" ? null : () {} ,
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
              decoration: const InputDecoration(labelText: "Nome*"),
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
              maxLength: 20,
              decoration: const InputDecoration(labelText: "Cel/Tel(opcional)"),
              style: const TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: observationController,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: "Observação(opcional)"),
              style: const TextStyle(fontSize: 18),
              maxLength: 1000,
            ),
          ],
        ),
      ),
    );
  }
}
