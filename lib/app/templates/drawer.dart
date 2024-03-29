import 'package:app_kayke_barbearia/app/pages/backup/backup_page.dart';
import 'package:app_kayke_barbearia/app/pages/client/client_list_page.dart';
import 'package:app_kayke_barbearia/app/pages/expense/expense_list_page.dart';
import 'package:app_kayke_barbearia/app/pages/payments/payment_list_page.dart';
import 'package:app_kayke_barbearia/app/pages/personal_expense/personal_expense_list_page.dart';
import 'package:app_kayke_barbearia/app/pages/product/product_list_page.dart';
import 'package:app_kayke_barbearia/app/pages/sale_provision_of_service/sales_and_provision_of_services_list_page.dart';
import 'package:app_kayke_barbearia/app/pages/service/service_list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerComponet extends StatelessWidget {
  const DrawerComponet({super.key});

  @override
  Widget build(BuildContext context) {
    void openScreen(dynamic page) {
      Scaffold.of(context).closeDrawer();
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
              "KAYKE BARBEARIA",
              style: TextStyle(fontSize: 20),
            ),
            currentAccountPicture: ClipOval(
              child: Image.asset(
                "assets/images/logo.jpg",
              ),
            ),
            currentAccountPictureSize: const Size.square(79),
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
              Icons.list,
              color: Colors.indigo,
            ),
            title: const Text(
              "Vendas e Serviços",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () => openScreen(
              const SalesAndProvisionOfServices(),
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
              Icons.backup,
              color: Colors.indigo,
            ),
            title: const Text(
              "Backup",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () => openScreen(const BackupPage()),
          ),
        ],
      ),
    );
  }
}
