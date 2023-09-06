import 'package:app_kaike_barbearia/app/pages/client_list_page.dart';
import 'package:app_kaike_barbearia/app/pages/payment_list_page.dart';
import 'package:app_kaike_barbearia/app/pages/personal_expense_list_page.dart';
import 'package:app_kaike_barbearia/app/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/service_list_page.dart';
import '../pages/expense_list_page.dart';

class DrawerComponet extends StatelessWidget {
  const DrawerComponet({super.key});

  @override
  Widget build(BuildContext context) {
    void openScreen(dynamic page) {
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: const Text(
              "KAIKE BARBEARIA",
              style: TextStyle(fontSize: 25),
            ),
            currentAccountPicture: ClipOval(
              child: Image.asset(
                "assets/images/logo.jpg",
              ),
            ),
            currentAccountPictureSize: const Size.square(89),
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.usersLine,
              color: Colors.indigo,
            ),
            title: const Text(
              "Clientes",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () => openScreen(
              const ClientListPage(itFromTheSalesScreen: false),
            ),
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.box,
              color: Colors.indigo,
            ),
            title: const Text(
              "Produtos",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () => openScreen(
              const ProductListPage(itFromTheSalesScreen: false),
            ),
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.screwdriverWrench,
              color: Colors.indigo,
            ),
            title: const Text(
              "Serviços",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () => openScreen(
              const ServiceListPage(itFromTheSalesScreen: false),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.payments_rounded,
              color: Colors.indigo,
            ),
            title: const Text(
              "Pagamentos",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () => openScreen(
              const PaymentListPage(),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.money_off,
              color: Colors.indigo,
            ),
            title: const Text(
              "Despesas B.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () => openScreen(
              const ExpenseListPage(itFromTheSalesScreen: false),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.money_off,
              color: Colors.indigo,
            ),
            title: const Text(
              "Despesas P.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () => openScreen(
              const PersonalExpenseListPage(itFromTheSalesScreen: false),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.tune,
              color: Colors.indigo,
            ),
            title: const Text(
              "Configurações",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
