import 'package:flutter/material.dart';

showModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) => const Center(
      child: Text("modal"),
    ),
  );
}
