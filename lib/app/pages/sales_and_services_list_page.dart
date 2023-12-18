import 'package:app_kayke_barbearia/app/controllers/provision_of_service_controller.dart';
import 'package:app_kayke_barbearia/app/controllers/sale_controller.dart';
import 'package:app_kayke_barbearia/app/template/dialog_filter.dart';
import 'package:app_kayke_barbearia/app/template/list_sales_and__provision_of_services.dart';
import 'package:app_kayke_barbearia/app/template/slide_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_page.dart';

class SalesAndServices extends StatefulWidget {
  const SalesAndServices({super.key});

  @override
  State<SalesAndServices> createState() => _SalesAndServicesState();
}

class _SalesAndServicesState extends State<SalesAndServices>
    with TickerProviderStateMixin {
  final searchController = TextEditingController();
  int month = DateTime.now().month - 1, year = DateTime.now().year;
  late TabController _tabController;
  String optionSelected = "Tudo",
      lastOptionSale = "Tudo",
      lastOptionService = "Tudo",
      tabSelected = "vendas",
      search = "";
  bool searchByName = false, confirmAction = false, isLoading = true;
  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> filteredSales = [],
      filteredByClient = [],
      filteredServices = [],
      sales = [],
      services = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadDetailSalesAndServices(
        "$year-${(month + 1).toString().padLeft(2, "0")}");
  }

  void loadDetailSalesAndServices(String monthAndYear) async {
    isLoading = true;
    sales = await SaleController.getSalesByDate(monthAndYear);
    filteredSales = List.from(sales);

    services = await ProvisionOfServiceController.getProvisionOfServicesByDate(
        monthAndYear);
    filteredServices = List.from(services);
    isLoading = false;
    setState(() {});
  }

  void filterLists(String option) {
    setState(() {
      if (option == "Tudo") {
        if (tabSelected == "vendas") {
          filteredSales = List.from(sales);
        } else {
          filteredServices = List.from(services);
        }
      } else {
        if (tabSelected == "vendas") {
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

  void filterByClient() {
    if (search.isNotEmpty) {
      filteredByClient = tabSelected == "vendas"
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
      filterLists(tabSelected == "vendas" ? lastOptionSale : lastOptionService);
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
                child: SlideDate(
                  year: year,
                  month: month,
                  onGetDate: onGetDate,
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
                    ListSalesAndProvisionOfServices(
                      isLoading: isLoading,
                      onload: () {
                        loadDetailSalesAndServices(
                            "$year-${(month + 1).toString().padLeft(2, "0")}");
                        setState(() {
                          confirmAction = true;
                        });
                      },
                      isService: tabSelected == "serviços",
                      typePayment: tabSelected,
                      itemsList:
                          search.isNotEmpty ? filteredByClient : filteredSales,
                    ),
                    ListSalesAndProvisionOfServices(
                      isLoading: isLoading,
                      onload: () {
                        loadDetailSalesAndServices(
                            "$year-${(month + 1).toString().padLeft(2, "0")}");
                        setState(() {
                          confirmAction = true;
                        });
                      },
                      isService: tabSelected == "serviços",
                      typePayment: tabSelected,
                      itemsList: search.isNotEmpty
                          ? filteredByClient
                          : filteredServices,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
