import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  List<String> options = ["money", "percentage"];
  String currentOptions = "";
  MoneyMaskedTextController discountValueController =
      MoneyMaskedTextController(leftSymbol: "R\$");

  @override
  void initState() {
    super.initState();
    currentOptions = options[0];

    initDicountController();
  }

  initDicountController() {
    setState(() {
      discountValueController = MoneyMaskedTextController(
          leftSymbol: currentOptions == "money" ? "R\$ " : "",
          rightSymbol: currentOptions == "percentage" ? "%" : "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desconto"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Radio(
                      activeColor: Theme.of(context).primaryColor,
                      value: options[0],
                      groupValue: currentOptions,
                      onChanged: (value) {
                        setState(() {
                          currentOptions = value.toString();
                          initDicountController();
                        });
                      },
                    ),
                    title: const Text("Dinheiro"),
                    horizontalTitleGap: 0,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Radio(
                      activeColor: Theme.of(context).primaryColor,
                      value: options[1],
                      groupValue: currentOptions,
                      onChanged: (value) {
                        setState(() {
                          currentOptions = value.toString();
                          initDicountController();
                        });
                      },
                    ),
                    title: const Text("Dinheiro"),
                    horizontalTitleGap: 0,
                  ),
                ),
              ],
            ),
            TextFormField(
              textAlign: TextAlign.center,
              controller: discountValueController,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Desconto"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  // price = discountValueController.numberValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
