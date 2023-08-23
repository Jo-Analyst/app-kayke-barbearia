import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ProductFormPage extends StatefulWidget {
  final bool isEdition;
  final String? name;
  final String? observation;
  final double? saleValue;
  final double? costValue;
  final double? profitValue;
  final int? quantity;
  final int? productId;
  const ProductFormPage({
    required this.isEdition,
    this.productId,
    this.name,
    this.saleValue,
    this.costValue,
    this.profitValue,
    this.quantity,
    this.observation,
    super.key,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  String name = "";
  double saleValue = 0, costValue = 0, profitValue = 0;
  int quantity = 0;
  final saleValueController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final costValueController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final observationController = TextEditingController();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final profitValueController = TextEditingController();

  calculateProfit() {
    setState(() {
      profitValue = saleValue - costValue;
    });
    profitValueController.text =
        profitValue.toStringAsFixed(2).replaceAll(RegExp(r'\.'), ',');
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isEdition) {
      profitValueController.text = "0,00";
      return;
    }

    nameController.text = widget.name ?? "";
    name = nameController.text;
    profitValue = widget.profitValue!;
    // saleValue =
    observationController.text = widget.observation ?? "";
    saleValueController.updateValue(widget.saleValue!);
    costValueController.updateValue(widget.costValue!);
    profitValueController.text =
        widget.profitValue!.toStringAsFixed(2).replaceAll(RegExp(r'\.'), ',');
    quantityController.text = widget.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produto"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: name.trim().isNotEmpty ? () {} : null,
              icon: const Icon(
                Icons.check,
                size: 30,
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
              textInputAction: TextInputAction.next,
              maxLength: 100,
              decoration: const InputDecoration(labelText: "Nome*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            TextFormField(
              controller: saleValueController,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Valor da venda"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  saleValue = saleValueController.numberValue;
                });
                calculateProfit();
              },
            ),
            TextFormField(
              controller: costValueController,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Valor do custo"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  costValue = costValueController.numberValue;
                });
                calculateProfit();
              },
            ),
            TextFormField(
              controller: profitValueController,
              readOnly: true,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Lucro",
                prefix: Text(
                  "R\$ ",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              style: const TextStyle(fontSize: 18),
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
