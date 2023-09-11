import 'package:app_kaike_barbearia/app/controllers/cash_flow_controller.dart';
import 'package:app_kaike_barbearia/app/template/calendar.dart';
import 'package:app_kaike_barbearia/app/template/finance_sale_list.dart';
import 'package:app_kaike_barbearia/app/template/finance_service.list.dart';
import 'package:app_kaike_barbearia/app/template/payment_container.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:app_kaike_barbearia/app/utils/search_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      valueReceived = 0,
      valueCompleted = 0;

  loadListSale() async {
    itemsSales = await CashFlowController.getListSales(dateSelected);
    setState(() {});
    print(itemsSales);
  }

  changeContainerSale() {
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

  changeContainerService() {
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

  loadFields() async {
    loadListSale();
    valueSale = await CashFlowController.getSumTotalSalesByDate(dateSelected);
    valueService =
        await CashFlowController.getSumTotalServicesByDate(dateSelected);
    balance = valueSale + valueService;
    setState(() {});
    loadFieldsPayments();
  }

  clearValuesFields() {
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

  loadFieldsPayments() async {
    valuesSalesBySpecies =
        await CashFlowController.getSumValuesSalesBySpecie(dateSelected);
    valuesServicesBySpecies =
        await CashFlowController.getSumValuesServicesBySpecie(dateSelected);
    loadValuesDefault();
  }

  loadValuesDefault() {
    clearValuesFields();
    getValuesForEachSpeciesOfSale();
    getValuesForEachSpeciesOfService();
    addValuesForEachSpecies();
  }

  addValuesForEachSpecies() {
    setState(() {
      valueMoney = valueMoneySale + valueMoneyService;
      valuePix = valuePixSale + valuePixService;
      valueCredit = valueCreditSale + valueCreditService;
      valueDebit = valueDebitSale + valueDebitService;
      valueCompleted = valueMoney + valuePix + valueCredit + valueDebit;
      if (!activeContainerSale && !activeContainerService) {
        valueReceived = balance - valueCompleted;
      } else if (activeContainerSale) {
        valueReceived = valueSale - valueCompleted;
      } else if (activeContainerService) {
        valueReceived = valueService - valueCompleted;
      }
    });
  }

// obter valores para cada espécie
  getValuesForEachSpeciesOfSale() {
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

  getValuesForEachSpeciesOfService() {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.only(right: 10),
            child: Calendar(
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
                      fontWeight: FontWeight.w500),
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
                        Text(
                          "Total Venda",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: activeContainerSale
                                ? Colors.white
                                : Colors.black,
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
                            fontSize: 24,
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
                  child: FinanceSaleList(itemsSale: itemsSales),
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
                  child: FinanceServiceList(
                    dateSelected: dateSelected,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 15,
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 2.4,
              children: [
                PaymentContainer(
                  icon: Icons.monetization_on,
                  specie: "Dinheiro",
                  value: valueMoney,
                  color: Theme.of(context).primaryColor,
                ),
                PaymentContainer(
                  icon: Icons.pix,
                  specie: "PIX",
                  value: valuePix,
                  color: Colors.green,
                ),
                PaymentContainer(
                  icon: Icons.credit_card,
                  specie: "Crédito",
                  value: valueCredit,
                  color: Colors.purple,
                ),
                PaymentContainer(
                  icon: Icons.credit_card,
                  specie: "Débito",
                  value: valueDebit,
                  color: Colors.purple,
                ),
                PaymentContainer(
                  icon: FontAwesomeIcons.handHoldingDollar,
                  specie: "A receber",
                  value: valueReceived,
                  color: Colors.redAccent,
                ),
                PaymentContainer(
                  icon: Icons.check_circle,
                  specie: "Concluído",
                  value: valueCompleted,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
