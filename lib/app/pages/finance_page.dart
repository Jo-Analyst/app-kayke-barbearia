import 'package:app_kayke_barbearia/app/controllers/finance_sale_values.dart';
import 'package:app_kayke_barbearia/app/template/finance_sales.dart';
import 'package:app_kayke_barbearia/app/template/finance_services.dart';
import 'package:app_kayke_barbearia/app/template/finance_expense.dart';
import 'package:app_kayke_barbearia/app/template/slide_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../template/finance_personal_expense.dart';
import '../template/field_for_period.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage>
    with TickerProviderStateMixin {
  int indexSlide = 0,
      indexPopMenu = 0,
      month = DateTime.now().month - 1,
      year = DateTime.now().year;
  late TabController _tabController;
  DateTime dateInitial = DateTime.now(), dateFinal = DateTime.now();
  List<Map<String, dynamic>> itemsSales = [];
  List<Map<String, dynamic>> itemsPaymentsSales = [];
  double valueTotalSale = 0;
  String monthAndYear = "";
  FinanceSaleValue financeSaleValue = FinanceSaleValue();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    monthAndYear = "${DateTime.now().month.toString().padLeft(2, "0")}/$year";
    loadValues();
  }

  loadValues() async {
    await financeSaleValue.loadValues(monthAndYear);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 11,
                child: indexPopMenu == 0
                    ? SlideDate(
                        year: year,
                        month: month,
                        onGetDate: (month, year) {
                          this.year = year;
                          this.month = month;
                          int subMonth = month + 1;
                          monthAndYear =
                              "${subMonth.toString().padLeft(2, "0")}/$year";
                          loadValues();
                        },
                      )
                    : FieldForPeriod(
                        dateInitial: dateInitial,
                        dateFinal: dateFinal,
                        onGetDates: (dateInitial, dateFinal) {
                          this.dateInitial = dateInitial;
                          this.dateFinal = dateFinal;
                        },
                      ),
              ),
              PopupMenuButton(
                color: Colors.indigo.withOpacity(.8),
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryColor,
                ),
                iconSize: 30,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem(
                    padding: EdgeInsets.zero,
                    value: "per-month",
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Por Mês",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "per-periodo",
                    padding: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Por Período",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
                onSelected: (option) async {
                  if (option == "per-month") {
                    setState(() {
                      indexPopMenu = 0;
                    });
                  } else {
                    setState(() {
                      indexPopMenu = 1;
                    });
                  }
                },
              ),
            ],
          ),
          Container(
            color: Colors.indigo.withOpacity(.1),
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.indigo,
              tabs: <Tab>[
                Tab(
                  text: null,
                  icon: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Vendas",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  text: null,
                  icon: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.screwdriverWrench,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Serviços",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  text: null,
                  icon: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.money_off,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Despesa Barbearia",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  text: null,
                  icon: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.money_off,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Despesa Pessoal",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              controller: _tabController,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height + 60,
            child: TabBarView(
              controller: _tabController,
              children: [
                FinanceSales(
                  financeSaleValue: financeSaleValue,
                ),
                const FinanceServices(),
                const FinanceExpense(),
                const FinancePersonalExpense(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
