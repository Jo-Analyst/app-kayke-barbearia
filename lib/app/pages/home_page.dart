import 'package:app_kaike_barbearia/app/pages/cash_flow_page.dart';
import 'package:app_kaike_barbearia/app/pages/finance_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../componente/drawer_component.dart';

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
        title:  Text(
          menuActived[0]["isActive"] ? "Balanço do mês" : "Fluxo de caixa",
          style: const TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: menuActived[0]["isActive"] ? const FinancePage() : const CashFlowPage(),
      ),
      drawer: const DrawerComponet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => changeActiveMenu(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_graph,
                    size: 35,
                    color: changeColor(menuActived[0]["isActive"]),
                  ),
                  Text(
                    "Finanças",
                    style: TextStyle(
                      color: changeColor(menuActived[0]["isActive"]),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => changeActiveMenu(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.sackDollar,
                    size: 35,
                    color: changeColor(menuActived[1]["isActive"]),
                  ),
                  Text(
                    "Fluxo de Caixa",
                    style: TextStyle(
                      color: changeColor(menuActived[1]["isActive"]),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
