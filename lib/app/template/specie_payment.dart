import 'package:app_kaike_barbearia/app/template/specie_payment_container.dart';
import 'package:flutter/material.dart';

class SpeciePayment extends StatefulWidget {
  const SpeciePayment({super.key});

  @override
  State<SpeciePayment> createState() => _SpeciePaymentState();
}

class _SpeciePaymentState extends State<SpeciePayment> {
  final List<bool> listSpeciePaymentsActive = [
    false,
    false,
    false,
    false,
    false,
    false
  ];

  changeColorAfterPaymentTypeBecomesActive(int index) {
    setState(() {
      for (int i = 0; i < listSpeciePaymentsActive.length; i++) {
        listSpeciePaymentsActive[i] = false;
      }

      listSpeciePaymentsActive[index] = true;
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
              onTap: () => changeColorAfterPaymentTypeBecomesActive(0),
              child: SpeciePaymentContainer(
                title: "Dinheiro",
                icon: Icons.attach_money,
                iconColor:
                    listSpeciePaymentsActive[0] ? Colors.white : Colors.green,
                backgroundColor: listSpeciePaymentsActive[0]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor:
                    listSpeciePaymentsActive[0] ? Colors.white : Colors.black,
              ),
            ),
            InkWell(
              onTap: () => changeColorAfterPaymentTypeBecomesActive(1),
              child: SpeciePaymentContainer(
                title: "Crédito",
                icon: Icons.credit_card,
                iconColor:
                    listSpeciePaymentsActive[1] ? Colors.white : Colors.purple,
                backgroundColor: listSpeciePaymentsActive[1]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor:
                    listSpeciePaymentsActive[1] ? Colors.white : Colors.black,
              ),
            ),
            InkWell(
              onTap: () => changeColorAfterPaymentTypeBecomesActive(2),
              child: SpeciePaymentContainer(
                title: "Débito",
                icon: Icons.credit_card,
                iconColor:
                    listSpeciePaymentsActive[2] ? Colors.white : Colors.purple,
                backgroundColor: listSpeciePaymentsActive[2]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor:
                    listSpeciePaymentsActive[2] ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => changeColorAfterPaymentTypeBecomesActive(3),
              child: SpeciePaymentContainer(
                title: "PIX",
                icon: Icons.pix,
                iconColor:
                    listSpeciePaymentsActive[3] ? Colors.white : Colors.green,
                backgroundColor: listSpeciePaymentsActive[3]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor:
                    listSpeciePaymentsActive[3] ? Colors.white : Colors.black,
              ),
            ),
            InkWell(
              onTap: () => changeColorAfterPaymentTypeBecomesActive(4),
              child: SpeciePaymentContainer(
                title: "Fiado",
                icon: Icons.person_2_outlined,
                iconColor:
                    listSpeciePaymentsActive[4] ? Colors.white : Colors.red,
                backgroundColor: listSpeciePaymentsActive[4]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor:
                    listSpeciePaymentsActive[4] ? Colors.white : Colors.black,
              ),
            ),
            InkWell(
              onTap: () => changeColorAfterPaymentTypeBecomesActive(5),
              child: SpeciePaymentContainer(
                title: "Parcial",
                icon: Icons.person,
                iconColor: listSpeciePaymentsActive[5]
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                backgroundColor: listSpeciePaymentsActive[5]
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                textColor:
                    listSpeciePaymentsActive[5] ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
