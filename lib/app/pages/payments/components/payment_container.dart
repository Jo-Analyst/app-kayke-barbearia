import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';


class PaymentContainer extends StatelessWidget {
  final IconData icon;
  final String specie;
  final double value;
  final Color color;
  final bool isItValueToBeReceived;
  const PaymentContainer({
    required this.icon,
    required this.isItValueToBeReceived,
    required this.specie,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isItValueToBeReceived
          ? null
          : MediaQuery.of(context).size.width / 2 - 20,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                specie,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    numberFormat.format(value),
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
