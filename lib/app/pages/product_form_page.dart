import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  String name = "";
  double valueSale = 0, costValue = 0, profitValue = 0;
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produto"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: name.isNotEmpty ? () {} : null,
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
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Valor custo*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  costValue =
                      value.trim().isNotEmpty ? double.parse(value) : 0.0;
                });
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Valor venda*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  valueSale =
                      value.trim().isNotEmpty ? double.parse(value) : 0.0;
                });
              },
            ),
            TextFormField(
              readOnly: true,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Lucro"),
              style: const TextStyle(fontSize: 18),
            ),
            TextFormField(
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
