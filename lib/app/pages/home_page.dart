import 'package:app_kayke_barbearia/app/pages/cash_flow_page.dart';
import 'package:app_kayke_barbearia/app/pages/finance_page.dart';
import 'package:app_kayke_barbearia/app/utils/modal.dart';
import 'package:app_kayke_barbearia/app/template/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../template/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> menuActived = [
    {"name": "list", "isActive": true},
    {"name": "shopp", "isActive": false},
  ];

  Color changeColor(bool isActive) {
    return isActive ? Colors.amberAccent : Colors.white;
  }

  changeActiveMenu(int index) {
    setState(() {
      for (var menu in menuActived) {
        menu["isActive"] = false;
      }
      menuActived[index]["isActive"] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          menuActived[0]["isActive"] ? "Resumo" : "Fluxo de caixa",
        ),
      ),
      body: menuActived[0]["isActive"]
          ? const FinancePage()
          : const CashFlowPage(),
      drawer: const DrawerComponet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showModal(context, const NewTransaction());
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => changeActiveMenu(0),
              icon: Icon(
                Icons.auto_graph,
                size: 35,
                color: changeColor(menuActived[0]["isActive"]),
              ),
            ),
            IconButton(
              onPressed: () => changeActiveMenu(1),
              icon: Icon(
                FontAwesomeIcons.sackDollar,
                size: 35,
                color: changeColor(menuActived[1]["isActive"]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
