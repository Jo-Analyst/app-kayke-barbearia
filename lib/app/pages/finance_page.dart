import 'package:app_kayke_barbearia/app/controllers/expense_balance_values.dart';
import 'package:app_kayke_barbearia/app/controllers/finance_sale_values.dart';
import 'package:app_kayke_barbearia/app/controllers/finance_service_values.dart';
import 'package:app_kayke_barbearia/app/template/finance_sales.dart';
import 'package:app_kayke_barbearia/app/template/finance_services.dart';
import 'package:app_kayke_barbearia/app/template/expense_balancete.dart';
import 'package:app_kayke_barbearia/app/template/slide_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../template/finance_personal_expense.dart';
import '../template/field_for_period.dart';
import '../utils/convert_values.dart';

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
  FinancesSalesValues financesSalesValues = FinancesSalesValues();
  FinancesServicesValues financesServicesValues = FinancesServicesValues();
  ExpenseBalanceValues expenseBalanceValues = ExpenseBalanceValues();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    monthAndYear = "$year-${DateTime.now().month.toString().padLeft(2, "0")}";
  }

  loadValuesByDate() async {
    await financesSalesValues.loadValuesByDate(monthAndYear);
    await financesServicesValues.loadValuesByDate(monthAndYear);
    await expenseBalanceValues.loadValuesByDate(monthAndYear);
    setState(() {});
  }

  loadValuesByPeriod() async {
    String dateInitial = dateFormat1.format(this.dateInitial),
        dateFinal = dateFormat1.format(this.dateFinal);
    await financesSalesValues.loadValuesByPeriod(dateInitial, dateFinal);
    await financesServicesValues.loadValuesByPeriod(dateInitial, dateFinal);
    await expenseBalanceValues.loadValuesByPeriod(dateInitial, dateFinal);
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
                              "$year-${subMonth.toString().padLeft(2, "0")}";
                          loadValuesByDate();
                        },
                      )
                    : FieldForPeriod(
                        dateInitial: dateInitial,
                        dateFinal: dateFinal,
                        onGetDates: (dateInitial, dateFinal) {
                          this.dateInitial = dateInitial;
                          this.dateFinal = dateFinal;
                          loadValuesByPeriod();
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
                      loadValuesByDate();
                    });
                  } else {
                    setState(() {
                      indexPopMenu = 1;
                      loadValuesByPeriod();
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
                FinanceSales(financesSalesValues: financesSalesValues),
                FinanceServices(financesServicesValues: financesServicesValues),
                ExpenseBalance(expenseBalanceValues: expenseBalanceValues),
                const FinancePersonalExpense(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
