import 'package:app_kayke_barbearia/app/providers/expense_provider.dart';
import 'package:app_kayke_barbearia/app/template/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../utils/content_message.dart';
import '../utils/convert_values.dart';
import '../utils/snackbar.dart';

class ExpenseFormPage extends StatefulWidget {
  final int? expenseId;
  final bool isEdition;
  final String? nameProduct;
  final double? price;
  final int? quantity;
  final DateTime? date;
  const ExpenseFormPage({
    this.expenseId,
    required this.isEdition,
    this.nameProduct,
    this.price,
    this.quantity,
    this.date,
    super.key,
  });

  @override
  State<ExpenseFormPage> createState() => _SpedingFormPageState();
}

class _SpedingFormPageState extends State<ExpenseFormPage> {
  final priceController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final nameProductController = TextEditingController();
  final quantityController = TextEditingController();
  DateTime dateSelected = DateTime.now();
  TimeOfDay timeSelected = TimeOfDay.now();
  String nameProduct = "";
  double price = 0;
  int quantity = 1;
  int expenseId = 0;

  @override
  void initState() {
    super.initState();

    if (!widget.isEdition) return;
    loadFields();
  }

  void loadFields() {
    setState(() {
      nameProduct = widget.nameProduct ?? "";
      nameProductController.text = nameProduct;
      quantity = widget.quantity ?? 1;
      quantityController.text = quantity.toString();
      price = widget.price ?? 0.0;
      priceController.updateValue(price);
      dateSelected = widget.date ?? DateTime.now();
      expenseId = widget.expenseId ?? 0;
    });
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 3000);
  }

  void saveExpense() async {
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    await expenseProvider.save({
      "id": expenseId,
      "name_product": nameProduct,
      "quantity": quantity,
      "date": dateFormat1.format(dateSelected),
      "price": price,
    });

    showMessage(
      ContentMessage(
        title: widget.isEdition
            ? "Despesa editada com sucesso."
            : "Despesa cadastrada com sucesso.",
        icon: Icons.info,
      ),
      null,
    );
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
              onPressed: nameProduct.isNotEmpty && price > 0
                  ? () {
                      saveExpense();
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
              controller: nameProductController,
              maxLength: 100,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Despesa*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  nameProduct = value.trim();
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
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration:
                  const InputDecoration(labelText: "Quantidade de itens"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  quantity = value.trim().isNotEmpty ? int.parse(value) : 1;
                });
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Calendar(
                dateInitial: dateSelected,
                onSelected: (value) {
                  setState(() {
                    dateSelected = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
