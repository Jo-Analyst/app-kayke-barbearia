import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'home.dart';

void main() async {
  // dotenv.load();
  initializeDateFormatting('pt_BR', null);
  runApp(const AppKaikeBarbearia());
}
