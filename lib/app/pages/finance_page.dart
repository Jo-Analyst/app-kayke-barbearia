import 'package:app_kaike_barbearia/app/template/finance_sales.dart';
import 'package:app_kaike_barbearia/app/template/finance_services.dart';
import 'package:app_kaike_barbearia/app/template/finance_expense.dart';
import 'package:app_kaike_barbearia/app/template/slide_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../template/finance_personal_expense.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage>
    with TickerProviderStateMixin {
  FinanceSales financeSales = const FinanceSales();
  FinanceServices financeServices = const FinanceServices();
  FinanceExpense financeExpense = const FinanceExpense();
  FinancePersonalExpense financePersonalExpense =
      const FinancePersonalExpense();
  int indexSlide = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SlideDate(),
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
              children: <Widget>[
                financeSales,
                financeServices,
                financeExpense,
                financePersonalExpense,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
