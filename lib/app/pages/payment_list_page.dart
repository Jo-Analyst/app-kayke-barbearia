import 'package:app_kaike_barbearia/app/template/dialog_filter.dart';
import 'package:app_kaike_barbearia/app/template/list_payment.dart';
import 'package:app_kaike_barbearia/app/utils/search_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentListPage extends StatefulWidget {
  const PaymentListPage({super.key});

  @override
  State<PaymentListPage> createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String optionSelected = "Tudo",
      lastOptionSale = "Tudo",
      lastOptionService = "Tudo",
      tabSelected = "vendas";
  List<Map<String, dynamic>> filteredPaymentsSales = [];
  List<Map<String, dynamic>> filteredPaymentsServices = [];
  List<Map<String, dynamic>> paymentsSales = [
    {
      "date_sale": "30/08/2023",
      "value": 100.00,
      "amount_paid": 100.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200.00,
      "amount_paid": 200.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "value": 100.00,
      "amount_paid": 100.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200.00,
      "amount_paid": 200.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "value": 100.00,
      "amount_paid": 100.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200.00,
      "amount_paid": 200.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "value": 100.00,
      "amount_paid": 100.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200.00,
      "amount_paid": 200.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "value": 100.00,
      "amount_paid": 0.0,
      "situation": "A receber"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200.00,
      "amount_paid": 0.0,
      "situation": "A receber"
    },
  ];
  List<Map<String, dynamic>> paymentsServices = [
    {
      "date_sale": "30/08/2023",
      "value": 100.00,
      "amount_paid": 100.00,
      "situation": "Recebido",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Joelmir Carvalho",
      "value": 200.00,
      "amount_paid": 200.00,
      "situation": "Recebido",
      "specie": "PIX"
    },
    {
      "date_sale": "30/08/2023",
      "value": 100.00,
      "amount_paid": 0.0,
      "situation": "A receber",
      "specie": "Dinheiro"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Joelmir Carvalho",
      "value": 200.00,
      "amount_paid": 0.0,
      "situation": "A receber",
      "specie": "PIX"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    filteredPaymentsSales = List.from(paymentsSales);
    filteredPaymentsServices = List.from(paymentsServices);
  }

  filterLists(String option) {
    setState(() {
      if (option == "Tudo") {
        if (tabSelected == "vendas") {
          filteredPaymentsSales = List.from(paymentsSales);
        } else {
          filteredPaymentsServices = List.from(paymentsServices);
        }
      } else {
        if (tabSelected == "vendas") {
          filteredPaymentsSales = paymentsSales
              .where((paymentSale) =>
                  paymentSale["situation"].toString().contains(option))
              .toList();
        } else {
          filteredPaymentsServices = paymentsServices
              .where((paymentService) =>
                  paymentService["situation"].toString().contains(option))
              .toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamentos"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.indigo.withOpacity(.1),
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () async {
                optionSelected = tabSelected == "vendas"
                    ? lastOptionSale
                    : lastOptionService;
                final option = await showFilterDialog(context, optionSelected);
                if (option == null) return;
                filterLists(option);
                setState(() {
                  optionSelected = option;
                  if (tabSelected == "vendas") {
                    lastOptionSale = option;
                  } else {
                    lastOptionService = option;
                  }
                });
              },
              icon: const Icon(Icons.filter_list),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              color: Colors.indigo.withOpacity(.1),
            ),
            child: TabBar(
              onTap: (value) {
                if (value == 0) {
                  tabSelected = "vendas";
                } else {
                  tabSelected = "serviços";
                }
              },
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
                          fontSize: 17,
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
                          fontSize: 17,
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
            height: MediaQuery.of(context).size.height - 240,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListPayment(payments: filteredPaymentsSales),
                ListPayment(payments: filteredPaymentsServices)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
