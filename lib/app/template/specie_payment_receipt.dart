import 'package:app_kaike_barbearia/app/template/specie_payment_container.dart';
import 'package:flutter/material.dart';

class SpeciePaymentReceipt extends StatefulWidget {
  final Function(String value, IconData icon) getPaymentTypeName;
  const SpeciePaymentReceipt({required this.getPaymentTypeName, super.key});

  @override
  State<SpeciePaymentReceipt> createState() => _SpeciePaymentReceiptState();
}

class _SpeciePaymentReceiptState extends State<SpeciePaymentReceipt> {
  final List<Map<String, dynamic>> listSpeciePayments = [
    {"specie": "dinheiro", "icon": Icons.attach_money, "isActive": true},
    {"specie": "crédito", "icon": Icons.credit_card, "isActive": false},
    {"specie": "débito", "icon": Icons.credit_card, "isActive": false},
    {"specie": "pix", "icon": Icons.pix, "isActive": false},
  ];

  changeColorAfterPaymentTypeBecomesActive(int index) {
    setState(() {
      for (var listSpecie in listSpeciePayments) {
        listSpecie["isActive"] = false;
      }

      listSpeciePayments[index]["isActive"] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                changeColorAfterPaymentTypeBecomesActive(0);
                widget.getPaymentTypeName(listSpeciePayments[0]["specie"],
                    listSpeciePayments[0]["icon"]);
              },
              child: SpeciePaymentContainer(
                width: MediaQuery.of(context).size.width / 2 - 27,
                title: "Dinheiro",
                icon: listSpeciePayments[0]["icon"],
                iconColor: listSpeciePayments[0]["isActive"]
                    ? Colors.white
                    : Colors.green,
                backgroundColor: listSpeciePayments[0]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePayments[0]["isActive"]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                changeColorAfterPaymentTypeBecomesActive(1);
                widget.getPaymentTypeName(listSpeciePayments[1]["specie"],
                    listSpeciePayments[1]["icon"]);
              },
              child: SpeciePaymentContainer(
                width: MediaQuery.of(context).size.width / 2 - 27,
                title: "Crédito",
                icon: listSpeciePayments[1]["icon"],
                iconColor: listSpeciePayments[1]["isActive"]
                    ? Colors.white
                    : Colors.purple,
                backgroundColor: listSpeciePayments[1]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePayments[1]["isActive"]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                changeColorAfterPaymentTypeBecomesActive(2);
                widget.getPaymentTypeName(listSpeciePayments[2]["specie"],
                    listSpeciePayments[2]["icon"]);
              },
              child: SpeciePaymentContainer(
                width: MediaQuery.of(context).size.width / 2 - 27,
                title: "Débito",
                icon: listSpeciePayments[2]["icon"],
                iconColor: listSpeciePayments[2]["isActive"]
                    ? Colors.white
                    : Colors.purple,
                backgroundColor: listSpeciePayments[2]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePayments[2]["isActive"]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                changeColorAfterPaymentTypeBecomesActive(3);
                widget.getPaymentTypeName(listSpeciePayments[3]["specie"],
                    listSpeciePayments[3]["icon"]);
              },
              child: SpeciePaymentContainer(
                width: MediaQuery.of(context).size.width / 2 - 27,
                title: "PIX",
                icon: listSpeciePayments[3]["icon"],
                iconColor: listSpeciePayments[3]["isActive"]
                    ? Colors.white
                    : Colors.green,
                backgroundColor: listSpeciePayments[3]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePayments[3]["isActive"]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
