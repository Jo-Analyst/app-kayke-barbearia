import 'package:app_kayke_barbearia/app/controllers/cash_flow_controller.dart';
import 'package:app_kayke_barbearia/app/pages/payments/components/payments_containers.dart';
import 'package:app_kayke_barbearia/app/templates/calendar.dart';
import 'package:app_kayke_barbearia/app/pages/financial/components/financial_report_sale_list.dart';
import 'package:app_kayke_barbearia/app/pages/financial/components/financial_report_service_list.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  DateTime dateSelected = DateTime.now();
  List<bool> containerButton = [false, false];
  List<Map<String, dynamic>> valuesSalesBySpecies = [];
  List<Map<String, dynamic>> valuesServicesBySpecies = [];
  List<Map<String, dynamic>> itemsSales = [];
  List<Map<String, dynamic>> servicesProvided = [];
  bool activeContainerSale = false;
  bool activeContainerService = false;
  double balance = 0,
      valueSale = 0,
      valueService = 0,
      valueMoney = 0,
      valueMoneySale = 0,
      valueMoneyService = 0,
      valuePix = 0,
      valuePixSale = 0,
      valuePixService = 0,
      valueCredit = 0,
      valueCreditSale = 0,
      valueCreditService = 0,
      valueDebit = 0,
      valueDebitSale = 0,
      valueDebitService = 0,
      amountToReceive = 0,
      amountReceived = 0,
      valueDiscountSale = 0,
      valueDiscountService = 0,
      valueDiscount = 0;

  void loadList() async {
    itemsSales = await CashFlowController.getListSales(dateSelected);
    servicesProvided = await CashFlowController.getListServices(dateSelected);
  }

  void changeContainerSale() {
    setState(() {
      activeContainerSale = !activeContainerSale;
      if (activeContainerSale) {
        activeContainerService = false;
      }
    });

    if (!activeContainerSale && !activeContainerService) {
      loadValuesDefault();
      return;
    }

    clearValuesFields();
    getValuesForEachSpeciesOfSale();
    addValuesForEachSpecies();
  }

  void changeContainerService() {
    setState(() {
      activeContainerService = !activeContainerService;
      if (activeContainerService) {
        activeContainerSale = false;
      }
    });

    if (!activeContainerSale && !activeContainerService) {
      loadValuesDefault();
      return;
    }

    clearValuesFields();
    getValuesForEachSpeciesOfService();
    addValuesForEachSpecies();
  }

  @override
  void initState() {
    super.initState();
    loadFields();
  }

  Future<void> loadFields() async {
    loadList();
    final sales = await CashFlowController.getSumTotalSalesByDate(dateSelected);
    valueSale = sales[0]["value_total"] ?? 0;
    valueDiscountSale = sales[0]["discount"] ?? 0;

    final services =
        await CashFlowController.getSumTotalServicesByDate(dateSelected);
    valueService = services[0]["value_total"] ?? 0;
    valueDiscountService = services[0]["discount"] ?? 0;

    balance = valueSale + valueService;

    setState(() {});
    loadFieldsPayments();
  }

  void clearValuesFields() {
    setState(() {
      valueMoneySale = 0;
      valueMoneyService = 0;
      valuePixSale = 0;
      valuePixService = 0;
      valueCreditSale = 0;
      valueCreditService = 0;
      valueDebitSale = 0;
      valueDebitService = 0;
    });
  }

  void loadFieldsPayments() async {
    valuesSalesBySpecies =
        await CashFlowController.getSumValuesSalesBySpecie(dateSelected);
    valuesServicesBySpecies =
        await CashFlowController.getSumValuesServicesBySpecie(dateSelected);
    loadValuesDefault();
  }

  void loadValuesDefault() {
    clearValuesFields();
    getValuesForEachSpeciesOfSale();
    getValuesForEachSpeciesOfService();
    addValuesForEachSpecies();
  }

  void addValuesForEachSpecies() {
    setState(() {
      valueMoney = valueMoneySale + valueMoneyService;
      valuePix = valuePixSale + valuePixService;
      valueCredit = valueCreditSale + valueCreditService;
      valueDebit = valueDebitSale + valueDebitService;
      amountReceived = valueMoney + valuePix + valueCredit + valueDebit;
      if (!activeContainerSale && !activeContainerService) {
        valueDiscount = valueDiscountSale + valueDiscountService;
        amountToReceive = balance - amountReceived;
      } else if (activeContainerSale) {
        amountToReceive = valueSale - amountReceived;
      } else if (activeContainerService) {
        amountToReceive = valueService - amountReceived;
      }
    });
  }

// obter valores para cada espécie
  void getValuesForEachSpeciesOfSale() {
    valueDiscount = valueDiscountSale;
    for (var valueSaleBySpecie in valuesSalesBySpecies) {
      if (valueSaleBySpecie["specie"].toString().toLowerCase() == "dinheiro") {
        valueMoneySale = valueSaleBySpecie["value"];
      }
      if (valueSaleBySpecie["specie"].toString().toLowerCase() == "pix") {
        valuePixSale = valueSaleBySpecie["value"];
      }
      if (valueSaleBySpecie["specie"].toString().toLowerCase() == "crédito") {
        valueCreditSale = valueSaleBySpecie["value"];
      }
      if (valueSaleBySpecie["specie"].toString().toLowerCase() == "débito") {
        valueDebitSale = valueSaleBySpecie["value"];
      }
    }
  }

  void getValuesForEachSpeciesOfService() {
    valueDiscount = valueDiscountService;
    for (var valueServiceBySpecie in valuesServicesBySpecies) {
      if (valueServiceBySpecie["specie"].toString().toLowerCase() ==
          "dinheiro") {
        valueMoneyService = valueServiceBySpecie["value"];
      }
      if (valueServiceBySpecie["specie"].toString().toLowerCase() == "pix") {
        valuePixService = valueServiceBySpecie["value"];
      }
      if (valueServiceBySpecie["specie"].toString().toLowerCase() ==
          "crédito") {
        valueCreditService = valueServiceBySpecie["value"];
      }
      if (valueServiceBySpecie["specie"].toString().toLowerCase() == "débito") {
        valueDebitService = valueServiceBySpecie["value"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: loadFields,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.only(right: 10),
              child: Calendar(
                dateTransaction: null,
                dateInitial: dateSelected,
                onSelected: (value) {
                  setState(() {
                    dateSelected = value;
                    activeContainerSale = false;
                    activeContainerService = false;
                    loadFields();
                  });
                },
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.indigo.withOpacity(.1),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  const Text(
                    "Saldo",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    numberFormat.format(balance),
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => changeContainerSale(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                        color: activeContainerSale
                            ? Theme.of(context).primaryColor
                            : null,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            numberFormat.format(valueSale),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: activeContainerSale
                                  ? Colors.white
                                  : Colors.green,
                            ),
                          ),
                          const SizedBox(height: 5),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Total Venda",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: activeContainerSale
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => changeContainerService(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                        color: activeContainerService
                            ? Theme.of(context).primaryColor
                            : null,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            numberFormat.format(valueService),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: activeContainerService
                                  ? Colors.white
                                  : Colors.green,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Total Serviço",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: activeContainerService
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 15,
              color: Theme.of(context).primaryColor,
            ),
            Visibility(
              visible: activeContainerSale && valueSale > 0,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text(
                      "Vendas:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    height: 15,
                  ),
                  Container(
                    color: Colors.indigo.withOpacity(.1),
                    height: 200,
                    child: FinancialReportSaleList(
                      isSearchByPeriod: false,
                      itemsSale: itemsSales,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: activeContainerService && valueService > 0,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text(
                      "Serviços:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    height: 15,
                  ),
                  Container(
                    color: Colors.indigo.withOpacity(.1),
                    height: 200,
                    child: FinancialReportServiceList(
                      isSearchByPeriod: false,
                      servicesProvided: servicesProvided,
                    ),
                  ),
                ],
              ),
            ),
            PaymentsContainers(
              valueMoney: valueMoney,
              valuePix: valuePix,
              valueCredit: valueCredit,
              valueDebit: valueDebit,
              amountToReceive: amountToReceive,
              amountReceived: amountReceived,
              valueDiscount: valueDiscount,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
