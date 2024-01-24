import 'package:app_kayke_barbearia/app/controllers/provision_of_service_controller.dart';
import 'package:app_kayke_barbearia/app/controllers/sale_controller.dart';
import 'package:app_kayke_barbearia/app/pages/home/home_page.dart';
import 'package:app_kayke_barbearia/app/templates/dialog_filter.dart';
import 'package:app_kayke_barbearia/app/pages/sale_and_provision_of_service/components/list_sales_and__provision_of_services.dart';
import 'package:app_kayke_barbearia/app/templates/slide_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TypeTransactionSelected { sales, services }

class SalesAndProvisionOfServices extends StatefulWidget {
  const SalesAndProvisionOfServices({super.key});

  @override
  State<SalesAndProvisionOfServices> createState() =>
      _SalesAndProvisionOfServicesState();
}

class _SalesAndProvisionOfServicesState
    extends State<SalesAndProvisionOfServices> with TickerProviderStateMixin {
  final searchController = TextEditingController();
  int month = DateTime.now().month - 1, year = DateTime.now().year;
  String optionSelected = "Tudo",
      lastOptionSale = "Tudo",
      lastOptionService = "Tudo",
      search = "";
  bool searchByName = false, confirmAction = false, isLoading = true;
  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> filteredSales = [],
      filteredByClient = [],
      filteredServices = [],
      sales = [],
      services = [];
  TypeTransactionSelected typeTransactionSelected = TypeTransactionSelected.sales;

  @override
  void initState() {
    super.initState();
    loadDetailSalesAndServices(
        "$year-${(month + 1).toString().padLeft(2, "0")}");
  }

  void loadDetailSalesAndServices(String monthAndYear) async {
    sales = await SaleController.getSalesByDate(monthAndYear);

    services = await ProvisionOfServiceController.getProvisionOfServicesByDate(
        monthAndYear);

    setState(() {
      filteredSales = List.from(sales);
      filteredServices = List.from(services);
      isLoading = false;
    });
  }

  void filterLists(String option) {
    setState(() {
      if (option == "Tudo") {
        if (typeTransactionSelected == TypeTransactionSelected.sales) {
          filteredSales = List.from(sales);
        } else {
          filteredServices = List.from(services);
        }
      } else {
        if (typeTransactionSelected == TypeTransactionSelected.sales) {
          filteredSales = sales
              .where((paymentSale) =>
                  paymentSale["situation"].toString().contains(option))
              .toList();

          if (search.isNotEmpty) {
            filteredSales = sales
                .where((paymentSale) =>
                    paymentSale["situation"].toString().contains(search))
                .toList();
          }
        } else {
          filteredServices = services
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
    this.month = month;
    this.year = year;
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
      filteredByClient = typeTransactionSelected == TypeTransactionSelected.sales
          ? filteredSales
              .where((paymentSale) => paymentSale["client_name"]
                  .toString()
                  .toLowerCase()
                  .contains(search.trim().toLowerCase()))
              .toList()
          : filteredServices
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

  void closeScreen() {
    if (confirmAction) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        closeScreen();

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => closeScreen(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Vendas e Serviços"),
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
                    Expanded(
                      child: Visibility(
                        visible: searchByName,
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
                            typeTransactionSelected = TypeTransactionSelected.sales;
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
                            color:
                                typeTransactionSelected == TypeTransactionSelected.sales
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
                            typeTransactionSelected = TypeTransactionSelected.services;
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
                  child: ListSalesAndProvisionOfServices(
                    isLoading: isLoading,
                    onload: () {
                      loadDetailSalesAndServices(
                          "$year-${(month + 1).toString().padLeft(2, "0")}");
                      setState(() {
                        confirmAction = true;
                      });
                    },
                    isService: true,
                    typeTransaction: typeTransactionSelected,
                    itemsList:
                        search.isNotEmpty ? filteredByClient : filteredServices,
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 310,
                  child: ListSalesAndProvisionOfServices(
                    isLoading: isLoading,
                    onload: () {
                      loadDetailSalesAndServices(
                          "$year-${(month + 1).toString().padLeft(2, "0")}");
                      setState(() {
                        confirmAction = true;
                      });
                    },
                    isService: false,
                    typeTransaction: typeTransactionSelected,
                    itemsList:
                        search.isNotEmpty ? filteredByClient : filteredSales,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
