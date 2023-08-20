import 'package:app_kaike_barbearia/app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  runApp(const AppKaikeBarbearia());
}

class AppKaikeBarbearia extends StatelessWidget {
  const AppKaikeBarbearia({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaike Barbearia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          toolbarHeight: 100,
          titleTextStyle: TextStyle(fontSize: 25),
        ),
        primaryColor: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        // useMaterial3: true,
      ),
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [
        Locale('pt', 'BR'),
        // Outros idiomas suportados, se necessário
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const HomePage(),
    );
  }
}
