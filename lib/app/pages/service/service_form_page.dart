import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/providers/service_provider.dart';
import 'package:app_kayke_barbearia/app/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';


class ServiceFormPage extends StatefulWidget {
  final int? serviceId;
  final bool isEdition;
  final String? description;
  final double? price;
  const ServiceFormPage({
    this.serviceId,
    required this.isEdition,
    this.description,
    this.price,
    super.key,
  });

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  final serviceValueController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final descriptionController = TextEditingController();
  String _description = "";
  double _priceService = 0;
  int _serviceId = 0;

  @override
  void initState() {
    super.initState();

    if (!widget.isEdition) return;
    _description = widget.description ?? "";
    descriptionController.text = _description;
    _priceService = widget.price ?? 0.0;
    serviceValueController.updateValue(_priceService);
    _serviceId = widget.serviceId ?? 0;
  }

  void saveService() async {
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    await serviceProvider.save({
      "id": _serviceId,
      "description": _description,
      "price": _priceService,
    });

    await Backup.toGenerate();

    showToast(
      message: widget.isEdition
          ? "Serviço editado com sucesso."
          : "Serviço cadastrado com sucesso.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serviço"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _description.isNotEmpty && _priceService > 0
                  ? () {
                      saveService();
                      Navigator.of(context).pop();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 18,
        ),
        child: ListView(
          children: [
            TextFormField(
              controller: descriptionController,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 100,
              decoration: const InputDecoration(labelText: "Serviço*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (description) {
                setState(() {
                  _description = description.trim();
                });
              },
              onFieldSubmitted: _description.isNotEmpty && _priceService > 0
                  ? (_) {
                      saveService();
                      Navigator.of(context).pop();
                    }
                  : null,
            ),
            TextFormField(
              controller: serviceValueController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Valor do serviço"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  _priceService = serviceValueController.numberValue;
                });
              },
              onFieldSubmitted: _description.isNotEmpty && _priceService > 0
                  ? (_) {
                      saveService();
                      Navigator.of(context).pop();
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
