import 'package:flutter/material.dart';

showModal(BuildContext context, dynamic page) {
  showModalBottomSheet(
    context: context,
    builder: (_) => page,
  );
}
