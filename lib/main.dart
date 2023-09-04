import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'home.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  runApp(const AppKaikeBarbearia());
}
