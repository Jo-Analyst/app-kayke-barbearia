import 'package:flutter/material.dart';

class FilterListPayment extends StatefulWidget {
  const FilterListPayment({super.key});

  @override
  State<FilterListPayment> createState() => _FilterListPaymentState();
}

class _FilterListPaymentState extends State<FilterListPayment> {
  List<String> options = ["Tudo", "Recebido", "A receber"];
  String currentOptions = "";

  @override
  void initState() {
    super.initState();
    currentOptions = options[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  changeMoney(String value) {
    setState(() {
      currentOptions = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Column(
            children: options.map(
              (option) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () => changeMoney(option.toString()),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Radio(
                          activeColor: Theme.of(context).primaryColor,
                          value: option,
                          groupValue: currentOptions,
                          onChanged: (value) => changeMoney(value ?? ""),
                        ),
                        title: Text(
                          option,
                          style: const TextStyle(fontSize: 20),
                        ),
                        horizontalTitleGap: 0,
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
