import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/providers/personal_expense_provider.dart';
import 'package:app_kayke_barbearia/app/templates/calendar.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';



class PersonalExpenseFormPage extends StatefulWidget {
  final int? personalExpenseId;
  final bool isEdition;
  final String? nameProduct;
  final double? price;
  final int? quantity;
  final DateTime? date;

  const PersonalExpenseFormPage({
    this.personalExpenseId,
    required this.isEdition,
    this.nameProduct,
    this.price,
    this.quantity,
    this.date,
    super.key,
  });

  @override
  State<PersonalExpenseFormPage> createState() =>
      _PersonalExpenseFormPageState();
}

class _PersonalExpenseFormPageState extends State<PersonalExpenseFormPage> {
  final priceController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final nameProductController = TextEditingController();
  final quantityController = TextEditingController();
  DateTime dateSelected = DateTime.now();
  TimeOfDay timeSelected = TimeOfDay.now();
  String _nameProduct = "";
  double price = 0;
  int quantity = 1;
  int personalExpenseId = 0;

  @override
  void initState() {
    super.initState();

    if (!widget.isEdition) return;
    loadFields();
  }

  void loadFields() {
    setState(() {
      _nameProduct = widget.nameProduct ?? "";
      nameProductController.text = _nameProduct;
      quantity = widget.quantity ?? 1;
      quantityController.text = quantity.toString();
      price = widget.price ?? 0.0;
      priceController.updateValue(price);
      dateSelected = widget.date ?? DateTime.now();
      personalExpenseId = widget.personalExpenseId ?? 0;
    });
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 3000);
  }

  void savePersonalExpense() async {
    final personalExpenseProvider =
        Provider.of<PersonalExpenseProvider>(context, listen: false);

    await personalExpenseProvider.save({
      "id": personalExpenseId,
      "name_product": _nameProduct,
      "quantity": quantity,
      "date": dateFormat1.format(dateSelected),
      "price": price,
    });

    await Backup.toGenerate();

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
        title: const Text("Despesa pessoal"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _nameProduct.isNotEmpty && price > 0
                  ? () {
                      savePersonalExpense();
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
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
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
