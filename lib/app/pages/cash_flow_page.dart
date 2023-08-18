import 'package:app_kaike_barbearia/app/template/finance_sale_list.dart';
import 'package:app_kaike_barbearia/app/template/finance_service.list.dart';
import 'package:app_kaike_barbearia/app/template/payment_container.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  DateTime dateSelected = DateTime.now();
  List<bool> containerButton = [false, false];
  bool activeContainerSale = false;
  bool activeContainerService = false;

  showCalendarPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2014),
      lastDate: DateTime.now(),
    ).then(
      (date) => setState(() {
        if (date != null) {
          dateSelected = date;
        }
      }),
    );
  }

  changeContainerSale() {
    setState(() {
      activeContainerSale = !activeContainerSale;
      if (activeContainerSale) activeContainerService = false;
    });
  }

  changeContainerService() {
    setState(() {
      activeContainerService = !activeContainerService;
      if (activeContainerService) activeContainerSale = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.only(right: 10),
            // color: Colors.indigo.withOpacity(.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => showCalendarPicker(),
                  child: Text(
                    dateFormat2.format(dateSelected),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: () => showCalendarPicker(),
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.indigo.withOpacity(.1),
            // margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                const Text(
                  "Saldo",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  numberFormat.format(300),
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
          // Divider(
          //   height: 15,
          //   color: Theme.of(context).primaryColor,
          // ),
          Container(
            // color: Colors.indigo.withOpacity(.1),
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
                          numberFormat.format(50),
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                              color: activeContainerSale
                                  ? Colors.white
                                  : Colors.green),
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
                          numberFormat.format(250),
                          style: TextStyle(
                            fontSize: 23,
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
            visible: activeContainerSale,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "Vendas:",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 15,
                ),
                Container(
                  color: Colors.indigo.withOpacity(.1),
                  height: 200,
                  child: const FinanceSaleList(),
                ),
              ],
            ),
          ),
          Visibility(
            visible: activeContainerService,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "Serviços:",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 15,
                ),
                Container(
                  color: Colors.indigo.withOpacity(.1),
                  height: 200,
                  child: const FinanceServiceList(),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              "Pagamentos:",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 2.5,
              children: const [
                PaymentContainer(
                  icon: Icons.monetization_on,
                  specie: "Dinheiro",
                  value: 200,
                ),
                PaymentContainer(
                  icon: Icons.pix,
                  specie: "PIX",
                  value: 100,
                ),
                PaymentContainer(
                  icon: Icons.credit_card,
                  specie: "Crédito",
                  value: 0,
                ),
                PaymentContainer(
                  icon: Icons.credit_card,
                  specie: "Débito",
                  value: 0,
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
