import 'package:app_kaike_barbearia/app/providers/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ClientFormPage extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? address;
  final int? clientId;

  const ClientFormPage({
    this.clientId,
    this.name,
    this.phone,
    this.address,
    super.key,
  });

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  String? _name = "";
  int clientId = 0;

  @override
  void initState() {
    super.initState();

    print(widget.clientId);
    if (widget.clientId == 0) return;
    clientId = widget.clientId ?? 0;
    _name = widget.name;
    nameController.text = _name ?? "";
    phoneController.text = widget.phone ?? "";
    addressController.text = widget.address ?? "";
  }

  saveClient() async {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    await clientProvider.save({
      "id": clientId,
      "name": _name,
      "phone": phoneController.text,
      "address": addressController.text
    });
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
              onPressed: _name == null || _name!.trim() == ""
                  ? null
                  : () {
                      saveClient();
                      Navigator.of(context).pop();
                    },
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
              keyboardType: TextInputType.phone,
              inputFormatters: [
                MaskTextInputFormatter(mask: "(##) # ####-####")
              ],
              maxLength: 20,
              decoration: const InputDecoration(labelText: "Cel/Tel(opcional)"),
              style: const TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: addressController,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: "Endereço(opcional)"),
              style: const TextStyle(fontSize: 18),
              maxLength: 1000,
            ),
          ],
        ),
      ),
    );
  }
}
