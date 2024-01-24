import 'package:app_kayke_barbearia/app/controllers/provision_of_service_controller.dart';
import 'package:app_kayke_barbearia/app/controllers/sale_controller.dart';
import 'package:app_kayke_barbearia/app/templates/dialog_filter.dart';
import 'package:app_kayke_barbearia/app/pages/payments/components/list_payment.dart';
import 'package:app_kayke_barbearia/app/templates/slide_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TypeTransactionSelected { sales, services }

class PaymentListPage extends StatefulWidget {
  const PaymentListPage({super.key});

  @override
  State<PaymentListPage> createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage>
    with TickerProviderStateMixin {
  TypeTransactionSelected typeTransactionSelected =
      TypeTransactionSelected.sales;
  final searchController = TextEditingController();
  int month = DateTime.now().month - 1, year = DateTime.now().year;
  String optionSelected = "Tudo",
      lastOptionSale = "Tudo",
      lastOptionService = "Tudo",
      search = "";
  bool searchByName = false, isLoading = true;
  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> filteredPaymentsSales = [],
      filteredPaymentsByClient = [],
      filteredPaymentsServices = [],
      paymentsSales = [],
      paymentsServices = [];

  @override
  void initState() {
    super.initState();
    loadDetailSalesAndServices(
        "$year-${(month + 1).toString().padLeft(2, "0")}");
  }

  void loadDetailSalesAndServices(String monthAndYear) async {
    isLoading = true;
    paymentsSales = await SaleController.getSalesByDate(monthAndYear);

    paymentsServices =
        await ProvisionOfServiceController.getProvisionOfServicesByDate(
            monthAndYear);

    setState(() {
      filteredPaymentsSales = List.from(paymentsSales);
      filteredPaymentsServices = List.from(paymentsServices);
      isLoading = false;
    });
  }

  void filterLists(String option) {
    setState(() {
      if (option == "Tudo") {
        if (typeTransactionSelected == TypeTransactionSelected.sales) {
          filteredPaymentsSales = List.from(paymentsSales);
        } else {
          filteredPaymentsServices = List.from(paymentsServices);
        }
      } else {
        if (typeTransactionSelected == TypeTransactionSelected.sales) {
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

  void onGetDate(month, year) {
    loadDetailSalesAndServices(
        "$year-${(month + 1).toString().padLeft(2, "0")}");
    optionSelected = "Tudo";
    lastOptionSale = "Tudo";
    lastOptionService = "Tudo";
  }

  void openDialogFilter() async {
    optionSelected = typeTransactionSelected == TypeTransactionSelected.sales
        ? lastOptionSale
        : lastOptionService;
    final option = await showFilterDialog(context, optionSelected);
    if (option == null) return;
    clearTextFormField();
    filterLists(option);

    setState(() {
      optionSelected = option;
      if (typeTransactionSelected == TypeTransactionSelected.sales) {
        lastOptionSale = option;
      } else {
        lastOptionService = option;
      }
    });
  }

  void filterByClient() {
    if (search.isNotEmpty) {
      filteredPaymentsByClient =
          typeTransactionSelected == TypeTransactionSelected.sales
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
      filterLists(typeTransactionSelected == TypeTransactionSelected.sales
          ? lastOptionSale
          : lastOptionService);
    }
  }

  void toggleSearch() {
    setState(() {
      searchByName = !searchByName;
    });

    if (!searchByName) {
      clearTextFormField();
    }
  }

  void clearTextFormField() {
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
                                      filterLists(typeTransactionSelected ==
                                              TypeTransactionSelected.sales
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
              child: SlideDate(
                year: year,
                month: month,
                onGetDate: onGetDate,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                color: Colors.indigo.withOpacity(.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          typeTransactionSelected =
                              TypeTransactionSelected.sales;
                          clearTextFormField();
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          color: typeTransactionSelected ==
                                  TypeTransactionSelected.sales
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: typeTransactionSelected ==
                                      TypeTransactionSelected.sales
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Vendas',
                              style: TextStyle(
                                fontSize: 20,
                                color: typeTransactionSelected ==
                                        TypeTransactionSelected.sales
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    padding: EdgeInsets.zero,
                    color: Colors.indigo.withOpacity(.5),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          typeTransactionSelected =
                              TypeTransactionSelected.services;
                          clearTextFormField();
                        });
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          color: typeTransactionSelected ==
                                  TypeTransactionSelected.services
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.screwdriverWrench,
                              color: typeTransactionSelected ==
                                      TypeTransactionSelected.services
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Serviços',
                              style: TextStyle(
                                fontSize: 20,
                                color: typeTransactionSelected ==
                                        TypeTransactionSelected.services
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: typeTransactionSelected == TypeTransactionSelected.sales,
              replacement: SizedBox(
                height: MediaQuery.of(context).size.height - 310,
                child: ListPayment(
                  isLoading: isLoading,
                  isService: true,
                  typeTransaction: typeTransactionSelected,
                  payments: search.isNotEmpty
                      ? filteredPaymentsByClient
                      : filteredPaymentsServices,
                ),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 310,
                child: ListPayment(
                  isLoading: isLoading,
                  isService: false,
                  typeTransaction: typeTransactionSelected,
                  payments: search.isNotEmpty
                      ? filteredPaymentsByClient
                      : filteredPaymentsSales,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
