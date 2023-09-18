import 'package:app_kayke_barbearia/app/template/payment_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentsContainers extends StatelessWidget {
  final double valueMoney;
  final double valuePix;
  final double valueCredit;
  final double valueDebit;
  final double amountToReceive;
  final double amountReceived;
  const PaymentsContainers({
    required this.valueMoney,
    required this.valuePix,
    required this.valueCredit,
    required this.valueDebit,
    required this.amountToReceive,
    required this.amountReceived,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PaymentContainer(
                icon: Icons.monetization_on,
                specie: "Dinheiro",
                value: valueMoney,
                color: Theme.of(context).primaryColor,
              ),
              PaymentContainer(
                icon: Icons.pix,
                specie: "PIX",
                value: valuePix,
                color: Colors.green,
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PaymentContainer(
                icon: Icons.credit_card,
                specie: "Crédito",
                value: valueCredit,
                color: Colors.purple,
              ),
              PaymentContainer(
                icon: Icons.credit_card,
                specie: "Débito",
                value: valueDebit,
                color: Colors.purple,
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PaymentContainer(
                icon: FontAwesomeIcons.handHoldingDollar,
                specie: "A receber",
                value: amountToReceive,
                color: Colors.redAccent,
              ),
              PaymentContainer(
                icon: Icons.check_circle,
                specie: "Recebido",
                value: amountReceived,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
