import 'package:app_kayke_barbearia/app/template/dialog_filter.dart';
import 'package:app_kayke_barbearia/app/template/list_payment.dart';
import 'package:app_kayke_barbearia/app/template/slide_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentListPage extends StatefulWidget {
  const PaymentListPage({super.key});

  @override
  State<PaymentListPage> createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage>
    with TickerProviderStateMixin {
  final searchController = TextEditingController();
  late TabController _tabController;
  String optionSelected = "Tudo",
      lastOptionSale = "Tudo",
      lastOptionService = "Tudo",
      tabSelected = "vendas",
      search = "";
  bool searchByName = false;
  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> filteredPaymentsSales = [],
      filteredPaymentsByClient = [],
      filteredPaymentsServices = [],
      paymentsSales = [
        {
          "date_payment": "30/08/2023",
          "value": 100.00,
          "amount_paid": 100.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "client_name": "Valdirene Aparecida Ferreira",
          "value": 200.00,
          "amount_paid": 200.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "value": 100.00,
          "amount_paid": 100.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "client_name": "Valdirene Aparecida Ferreira",
          "value": 200.00,
          "amount_paid": 200.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "value": 100.00,
          "amount_paid": 100.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "client_name": "Valdirene Aparecida Ferreira",
          "value": 200.00,
          "amount_paid": 200.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "value": 100.00,
          "amount_paid": 100.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "client_name": "Valdirene Aparecida Ferreira",
          "value": 200.00,
          "amount_paid": 200.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "value": 100.00,
          "amount_paid": 0.0,
          "situation": "A receber"
        },
        {
          "date_payment": "30/08/2023",
          "client_name": "Valdirene Aparecida Ferreira",
          "value": 200.00,
          "amount_paid": 0.0,
          "situation": "A receber"
        },
      ],
      paymentsServices = [
        {
          "date_payment": "30/08/2023",
          "value": 100.00,
          "amount_paid": 100.00,
          "situation": "Recebido",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
          "client_name": "Joelmir Carvalho",
          "value": 200.00,
          "amount_paid": 200.00,
          "situation": "Recebido",
          "specie": "PIX"
        },
        {
          "date_payment": "30/08/2023",
          "value": 100.00,
          "amount_paid": 0.0,
          "situation": "A receber",
          "specie": "Dinheiro"
        },
        {
          "date_payment": "30/08/2023",
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

          if (search.isNotEmpty) {
            filteredPaymentsSales = paymentsSales
                .where((paymentSale) =>
                    paymentSale["situation"].toString().contains(search))
                .toList();
          }
        } else {
          filteredPaymentsServices = paymentsServices
              .where((paymentService) =>
                  paymentService["situation"].toString().contains(option))
              .toList();
        }
      }
    });
  }

  openDialogFilter() async {
    optionSelected =
        tabSelected == "vendas" ? lastOptionSale : lastOptionService;
    final option = await showFilterDialog(context, optionSelected);
    if (option == null) return;
    clearTextFormField();
    filterLists(option);

    setState(() {
      optionSelected = option;
      if (tabSelected == "vendas") {
        lastOptionSale = option;
      } else {
        lastOptionService = option;
      }
    });
  }

  filterByClient() {
    if (search.isNotEmpty) {
      filteredPaymentsByClient = tabSelected == "vendas"
          ? filteredPaymentsSales
              .where((paymentSale) => paymentSale["client_name"]
                  .toString()
                  .toLowerCase()
                  .contains(search.trim().toLowerCase()))
              .toList()
          : filteredPaymentsServices
              .where((paymentService) => paymentService["client_name"]
                  .toString()
                  .toLowerCase()
                  .contains(search.trim().toLowerCase()))
              .toList();
    } else {
      filterLists(tabSelected == "vendas" ? lastOptionSale : lastOptionService);
    }
  }

  toggleSearch() {
    setState(() {
      searchByName = !searchByName;
    });

    if (!searchByName) {
      clearTextFormField();
    }
  }

  clearTextFormField() {
    searchController.text = "";
    filterByClient();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      search = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamentos"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.indigo.withOpacity(.1),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: searchByName,
                    child: Expanded(
                      child: TextFormField(
                        focusNode: _focusNode,
                        controller: searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Digite para buscar o cliente",
                          suffixIcon: search.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    searchController.text = "";
                                    setState(() {
                                      search = "";
                                      filterLists(tabSelected == "vendas"
                                          ? lastOptionSale
                                          : lastOptionService);
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            search = value;
                            filterByClient();
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => toggleSearch(),
                    icon: Icon(
                      searchByName ? Icons.search_off_sharp : Icons.search,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () => openDialogFilter(),
                    icon: const Icon(
                      Icons.filter_list,
                      size: 30,
                    ),
                  ),
                ],
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
              child: const SlideDate(),
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

                  clearTextFormField();
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
              height: MediaQuery.of(context).size.height - 310,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ListPayment(
                    payments: search.isNotEmpty
                        ? filteredPaymentsByClient
                        : filteredPaymentsSales,
                  ),
                  ListPayment(
                    payments: search.isNotEmpty
                        ? filteredPaymentsByClient
                        : filteredPaymentsServices,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
