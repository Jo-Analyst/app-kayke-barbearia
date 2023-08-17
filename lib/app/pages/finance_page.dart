import 'package:app_kaike_barbearia/app/template/finance_sales.dart';
import 'package:app_kaike_barbearia/app/template/finance_services.dart';
import 'package:app_kaike_barbearia/app/template/finance_spending.dart';
import 'package:app_kaike_barbearia/app/template/slide_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage>
    with TickerProviderStateMixin {
  List<Widget> components = [
    const FinanceSales(),
    const FinanceServices(),
    const FinanceSpending(),
  ];
  int indexSlide = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              indicatorColor: Colors.indigo,
              tabs: <Tab>[
                Tab(
                  text: null,
                  icon: null,
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Vendas",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                Tab(
                  text: null,
                  icon: null,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.screwdriverWrench,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Serviços",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                Tab(
                  text: null,
                  icon: null,
                  child: Row(
                    children: [
                      Icon(
                        Icons.money_off,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Despesa",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
              controller: _tabController,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height + 30,
            child: Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  FinanceSales(),
                  FinanceServices(),
                  FinanceSpending(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}