import 'package:flutter/material.dart';

class SpeciePaymentContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  const SpeciePaymentContainer({
    required this.title,
    required this.icon,
    this.iconColor,
    this.textColor,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20, color: textColor),
          )
        ],
      ),
    );
  }
}
