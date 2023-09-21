import 'package:app_kayke_barbearia/app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '../utils/content_message.dart';
import '../utils/snackbar.dart';

class ProductFormPage extends StatefulWidget {
  final bool isEdition;
  final String? name;
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
    super.key,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  String name = "";
  double saleValue = 0, costValue = 0, profitValue = 0;
  int quantity = 0, productId = 0;
  final saleValueController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final costValueController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final profitValueController = TextEditingController();

  void calculateProfit() {
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

    productId = widget.productId ?? 0;
    nameController.text = widget.name ?? "";
    name = nameController.text;
    profitValue = widget.profitValue!;
    saleValueController.updateValue(widget.saleValue!);
    costValueController.updateValue(widget.costValue!);
    profitValueController.text =
        widget.profitValue!.toStringAsFixed(2).replaceAll(RegExp(r'\.'), ',');
    quantity = widget.quantity ?? 0;
    quantityController.text = quantity.toString();
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  saveProduct() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.save({
      "id": productId,
      "name": name.trim(),
      "sale_value": saleValueController.numberValue,
      "cost_value": costValueController.numberValue,
      "profit_value": profitValue,
      "quantity": quantity,
    });

    showMessage(
      ContentMessage(
        title: widget.isEdition
            ? "Produto editado com sucesso."
            : "Produto cadastrado com sucesso.",
        icon: Icons.info,
      ),
      null,
    );
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
              onPressed: name.trim().isNotEmpty && quantity > 0
                  ? () {
                      saveProduct();
                      Navigator.of(context).pop();
                    }
                  : null,
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
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              maxLength: 100,
              decoration: const InputDecoration(labelText: "Nome*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              onFieldSubmitted: name.trim().isNotEmpty && quantity > 0
                  ? (_) {
                      saveProduct();
                      Navigator.of(context).pop();
                    }
                  : null,
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
              textInputAction: TextInputAction.done,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Quantidade de itens*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  quantity = value.trim().isNotEmpty ? int.parse(value) : 0;
                });
              },
              onFieldSubmitted: name.trim().isNotEmpty && quantity > 0
                  ? (_) {
                      saveProduct();
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
