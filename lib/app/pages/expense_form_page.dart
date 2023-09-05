import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../utils/convert_values.dart';

class SpedingFormPage extends StatefulWidget {
  final int? spedingId;
  final bool isEdition;
  final String? nameProduct;
  final double? price;
  final int? quantity;
  final DateTime? date;
  const SpedingFormPage({
    this.spedingId,
    required this.isEdition,
    this.nameProduct,
    this.price,
    this.quantity,
    this.date,
    super.key,
  });

  @override
  State<SpedingFormPage> createState() => _SpedingFormPageState();
}

class _SpedingFormPageState extends State<SpedingFormPage> {
  final priceController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final nameProductController = TextEditingController();
  final quantityController = TextEditingController();
  DateTime dateSelected = DateTime.now();
  TimeOfDay timeSelected = TimeOfDay.now();
  String _nameProduct = "";
  double price = 0;
  int quantity = 0;

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
    loadFields();
  }

  loadFields() {
    setState(() {
      _nameProduct = widget.nameProduct ?? "";
      nameProductController.text = _nameProduct;
      quantity = widget.quantity ?? 0;
      quantityController.text = quantity.toString();
      price = widget.price ?? 0.0;
      priceController.updateValue(price);
      dateSelected = widget.date ?? DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesa"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _nameProduct.isNotEmpty && price > 0 && quantity > 0
                  ? () {}
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
              controller: nameProductController,
              maxLength: 100,
              decoration: const InputDecoration(labelText: "Despesa*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (nameProduct) {
                setState(() {
                  _nameProduct = nameProduct.trim();
                });
              },
            ),
            TextFormField(
              controller: priceController,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Valor da despesa"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  price = priceController.numberValue;
                });
              },
            ),
            TextFormField(
              controller: quantityController,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration:
                  const InputDecoration(labelText: "Quantidade de itens*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  quantity = value.trim().isNotEmpty ? int.parse(value) : 0;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => showCalendarPicker(),
                  child: Text(
                    dateFormat2.format(dateSelected),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: () => showCalendarPicker(),
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
