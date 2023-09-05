import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

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
  DateTime dateSelected = DateTime.now();
  TimeOfDay timeSelected = TimeOfDay.now();
  String _description = "";
  double priceService = 0;

  showCalendarPicker() {
    showDatePicker(
      context: context,
      initialDate: dateSelected,
      firstDate: DateTime(2014),
      lastDate: DateTime.now(),
    ).then(
      (date) => setState(() {
        if (date != null) {
          dateSelected = date;
        }
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isEdition) return;
    _description = widget.description ?? "";
    descriptionController.text = _description;
    priceService = widget.price ?? 0.0;
    serviceValueController.updateValue(priceService);
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
              onPressed:
                  _description.isNotEmpty && priceService > 0 ? () {} : null,
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
              maxLength: 100,
              decoration: const InputDecoration(labelText: "Serviço*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (description) {
                setState(() {
                  _description = description.trim();
                });
              },
            ),
            TextFormField(
              controller: serviceValueController,
              autofocus: true,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Valor do serviço"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  priceService = serviceValueController.numberValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
