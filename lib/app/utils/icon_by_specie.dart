import 'package:flutter/material.dart';

class IconBySpecie extends StatefulWidget {
  final String specie;
  const IconBySpecie({
    required this.specie,
    super.key,
  });

  @override
  State<IconBySpecie> createState() => _IconBySpecieState();
}

class _IconBySpecieState extends State<IconBySpecie> {
  Icon icon() {
    Icon icon = Icon(
      Icons.monetization_on,
      color: Theme.of(context).primaryColor,
    );

    if (widget.specie.toLowerCase() == "pix") {
      icon = const Icon(
        Icons.pix,
        color: Colors.green,
      );
    }

    if (widget.specie.toLowerCase() == "crédito" ||
        widget.specie.toLowerCase() == "débito") {
      icon = const Icon(
        Icons.credit_card,
        color: Colors.purple,
      );
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return icon();
  }
}
