import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/pages/cash_flow_page.dart';
import 'package:app_kayke_barbearia/app/pages/financial_report_page.dart';
import 'package:app_kayke_barbearia/app/utils/dialog_exit_app.dart';
import 'package:app_kayke_barbearia/app/utils/modal.dart';
import 'package:app_kayke_barbearia/app/template/new_transaction.dart';
import 'package:app_kayke_barbearia/app/utils/permission_use_app.dart';
import 'package:app_kayke_barbearia/app/utils/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

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

  void changeActiveMenu(int index) {
    setState(() {
      for (var menu in menuActived) {
        menu["isActive"] = false;
      }
      menuActived[index]["isActive"] = true;
    });
  }

  Future<bool> screen() async {
    final confirmExit = await showDialogApp(
        context, "Deseja gerar backup ao sair do aplicativo?");
    if (confirmExit != null) {
      if (confirmExit == "Sair e gerar backup") {
        bool isGranted = await isGrantedRequestPermissionStorage();

        if (isGranted) {
          await Backup.toGenerate();
          ShareUtils.share();
        } else {
          openAppSettings();
          return false;
        }
      }

      SystemNavigator.pop(animated: false);
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: screen,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            menuActived[0]["isActive"] ? "Resumo" : "Fluxo de caixa",
          ),
        ),
        body: menuActived[0]["isActive"]
            ? const FinancialReportPage()
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
      ),
    );
  }
}
