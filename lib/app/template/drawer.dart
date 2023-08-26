import 'package:app_kaike_barbearia/app/pages/client_list_page.dart';
import 'package:app_kaike_barbearia/app/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/service_list_page.dart';
import '../pages/speding_list_page.dart';

class DrawerComponet extends StatelessWidget {
  const DrawerComponet({super.key});

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      const ClientListPage(itFromTheSalesScreen: false),
                ),
              );
            },
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
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProductListPage(
                    itFromTheSalesScreen: false,
                  ),
                ),
              );
            },
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
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ServiceListPage(
                    itFromTheSalesScreen: false,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.money_off,
              color: Colors.indigo,
            ),
            title: const Text(
              "Despesas",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
              ),
            ),
            onTap: () { Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SpedingListPage(
                    itFromTheSalesScreen: false,
                  ),
                ),
              );},
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
            onTap: () {},
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
