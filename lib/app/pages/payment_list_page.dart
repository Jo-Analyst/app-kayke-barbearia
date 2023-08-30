import 'package:app_kaike_barbearia/app/template/list_payment_receivable.dart';
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
  List<Map<String, dynamic>> paymentsSales = [
    {
      "date_sale": "30/08/2023",
      "client_name": "client avulso",
      "value": 100,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "client avulso",
      "value": 100,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "client avulso",
      "value": 100,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "client avulso",
      "value": 100,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "client avulso",
      "value": 100,
      "situation": "A receber"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Valdirene Aparecida Ferreira",
      "value": 200,
      "situation": "A receber"
    },
  ];
  List<Map<String, dynamic>> paymentsServices = [
    {
      "date_sale": "30/08/2023",
      "client_name": "client avulso",
      "value": 100,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Joelmir Carvalho",
      "value": 200,
      "situation": "Recebido"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "client avulso",
      "value": 100,
      "situation": "A receber"
    },
    {
      "date_sale": "30/08/2023",
      "client_name": "Joelmir Carvalho",
      "value": 200,
      "situation": "A receber"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamentos"),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.indigo.withOpacity(.1),
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
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
                        "Venda",
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
                ListPaymentReceivable(toReceive: paymentsSales),
                ListPaymentReceivable(toReceive: paymentsServices)
              ],
            ),
          ),
        ],
      ),
    );
  }
}