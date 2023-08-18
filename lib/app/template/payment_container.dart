import 'package:flutter/material.dart';

import '../utils/convert_values.dart';

class PaymentContainer extends StatelessWidget {
  final IconData icon;
  final String specie;
  final double value;
  const PaymentContainer({
    required this.icon,
    required this.specie,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,vertical: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 30,
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
              Expanded(
                child: Text(
                  numberFormat.format(1020),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
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
