import 'package:app_kaike_barbearia/app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppKaikeBarbearia());
}

class AppKaikeBarbearia extends StatelessWidget {
  const AppKaikeBarbearia({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaike Barbearia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        // useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
