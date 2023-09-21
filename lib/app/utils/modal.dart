import 'package:flutter/material.dart';

void showModal(BuildContext context, dynamic page) {
  showModalBottomSheet(
    context: context,
    builder: (_) => page,
  );
}
