import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class DiscountPage extends StatefulWidget {
  final double subtotal;
  const DiscountPage({required this.subtotal, super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  List<String> options = ["money", "percentage"];
  String currentOptions = "";
  double money = 0, percentage = 0, netValue = 0;
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
      money = 0;
      percentage = 0;
      netValue = widget.subtotal;
    });
  }

  calculateDiscount() {
    setState(() {
      if (currentOptions == "money") {
        money = discountValueController.numberValue;
      } else {
        percentage = discountValueController.numberValue;
      }
      convertValuesMoneyAndPercentage();
      netValue = widget.subtotal - money;
    });
  }

  convertValuesMoneyAndPercentage() {
    if (currentOptions == "money") {
      percentage = (money * 100) / widget.subtotal;
    } else {
      money = (widget.subtotal * percentage) / 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desconto"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop(money);
              },
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
          horizontal: 15,
          vertical: 10,
        ),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
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
                    title: const Text(
                      "Dinheiro",
                      style: TextStyle(fontSize: 20),
                    ),
                    horizontalTitleGap: 0,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
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
                    title: const Text(
                      "Percentual",
                      style: TextStyle(fontSize: 20),
                    ),
                    horizontalTitleGap: 0,
                  ),
                ),
              ],
            ),
            TextFormField(
              scrollPadding: EdgeInsets.zero,
              textAlign: TextAlign.center,
              controller: discountValueController,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                if (currentOptions == "percentage") {
                  if (discountValueController.numberValue >= 100) {
                    discountValueController.updateValue(100.00);
                  }
                } else {
                  if (discountValueController.numberValue >=
                      widget.subtotal) {
                    discountValueController.updateValue(widget.subtotal);
                  }
                }
                calculateDiscount();
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Valor total",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        numberFormat.format(widget.subtotal),
                        style: const TextStyle(
                          decoration:
                              TextDecoration.lineThrough, // Adiciona o traço
                          decorationColor:
                              Color.fromARGB(255, 65, 65, 65), // Cor do traço
                          decorationThickness: 1.5, // Espessura do traço
                          decorationStyle: TextDecorationStyle.solid,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Valor c/ desconto",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        numberFormat.format(netValue),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(20),
              color: Colors.indigo.withOpacity(.1),
              child: Text(
                "Desconto: ${numberFormat.format(money)} (${percentage.toStringAsFixed(2).replaceAll(RegExp(r'\.'), ',')}%)",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
