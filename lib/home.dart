import 'package:app_kayke_barbearia/app/providers/client_provider.dart';
import 'package:app_kayke_barbearia/app/providers/provision_of_service_provider.dart';
import 'package:app_kayke_barbearia/app/providers/sale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app/pages/home_page.dart';
import 'app/providers/expense_provider.dart';
import 'app/providers/personal_expense_provider.dart';
import 'app/providers/product_provider.dart';
import 'app/providers/service_provider.dart';

class AppKaikeBarbearia extends StatelessWidget {
  const AppKaikeBarbearia({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => PersonalExpenseProvider()),
        ChangeNotifierProvider(create: (_) => SaleProvider()),
        ChangeNotifierProvider(create: (_) => ProvisionOfServiceProvider()),
      ],
      child: MaterialApp(
        title: 'Kaike Barbearia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            toolbarHeight: 80,
            titleTextStyle: TextStyle(fontSize: 20),
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
      ),
    );
  }
}
