import 'package:app_kaike_barbearia/app/template/specie_payment_container.dart';
import 'package:flutter/material.dart';

class SpeciePayment extends StatefulWidget {
  final Function(String value) getPaymentTypeName;
  const SpeciePayment({required this.getPaymentTypeName, super.key});

  @override
  State<SpeciePayment> createState() => _SpeciePaymentState();
}

class _SpeciePaymentState extends State<SpeciePayment> {
  final List<Map<String, dynamic>> listSpeciePaymentsActive = [
    {"specie": "dinheiro", "isActive": true},
    {"specie": "crédito", "isActive": false},
    {"specie": "débito", "isActive": false},
    {"specie": "pix", "isActive": false},
    {"specie": "fiado", "isActive": false},
    {"specie": "parcial", "isActive": false},
  ];

  changeColorAfterPaymentTypeBecomesActive(int index) {
    setState(() {
      for (var listSpecie in listSpeciePaymentsActive) {
        listSpecie["isActive"] = false;
      }

      listSpeciePaymentsActive[index]["isActive"] = true;
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
                widget.getPaymentTypeName(listSpeciePaymentsActive[0]["specie"]);
              },
              child: SpeciePaymentContainer(
                title: "Dinheiro",
                icon: Icons.attach_money,
                iconColor: listSpeciePaymentsActive[0]["isActive"]
                    ? Colors.white
                    : Colors.green,
                backgroundColor: listSpeciePaymentsActive[0]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePaymentsActive[0]["isActive"]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                changeColorAfterPaymentTypeBecomesActive(1);
                widget.getPaymentTypeName(listSpeciePaymentsActive[1]["specie"]);
              },
              child: SpeciePaymentContainer(
                title: "Crédito",
                icon: Icons.credit_card,
                iconColor: listSpeciePaymentsActive[1]["isActive"]
                    ? Colors.white
                    : Colors.purple,
                backgroundColor: listSpeciePaymentsActive[1]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePaymentsActive[1]["isActive"]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                changeColorAfterPaymentTypeBecomesActive(2);
                widget.getPaymentTypeName(listSpeciePaymentsActive[2]["specie"]);
              },
              child: SpeciePaymentContainer(
                title: "Débito",
                icon: Icons.credit_card,
                iconColor: listSpeciePaymentsActive[2]["isActive"]
                    ? Colors.white
                    : Colors.purple,
                backgroundColor: listSpeciePaymentsActive[2]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePaymentsActive[2]["isActive"]
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
                changeColorAfterPaymentTypeBecomesActive(3);
                widget.getPaymentTypeName(listSpeciePaymentsActive[3]["specie"]);
              },
              child: SpeciePaymentContainer(
                width: 178,
                title: "PIX",
                icon: Icons.pix,
                iconColor: listSpeciePaymentsActive[3]["isActive"]
                    ? Colors.white
                    : Colors.green,
                backgroundColor: listSpeciePaymentsActive[3]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePaymentsActive[3]["isActive"]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                changeColorAfterPaymentTypeBecomesActive(4);
                widget.getPaymentTypeName(listSpeciePaymentsActive[4]["specie"]);
              },
              child: SpeciePaymentContainer(
                width: 178,
                title: "Fiado",
                icon: Icons.person_2_outlined,
                iconColor: listSpeciePaymentsActive[4]["isActive"]
                    ? Colors.white
                    : Colors.red,
                backgroundColor: listSpeciePaymentsActive[4]["isActive"]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor: listSpeciePaymentsActive[4]["isActive"]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            // InkWell(
            //   onTap: () => changeColorAfterPaymentTypeBecomesActive(5),
            //   child: SpeciePaymentContainer(
            //     title: "Parcial",
            //     icon: Icons.person,
            //     iconColor: listSpeciePaymentsActive[5]["isActive"]
            //         ? Colors.white
            //         : Theme.of(context).primaryColor,
            //     backgroundColor: listSpeciePaymentsActive[5]["isActive"]
            //         ? Theme.of(context).primaryColor
            //         : Colors.white,
            //     textColor: listSpeciePaymentsActive[5]["isActive"]
            //         ? Colors.white
            //         : Colors.black,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
