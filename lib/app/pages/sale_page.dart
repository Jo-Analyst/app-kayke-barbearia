import 'package:app_kaike_barbearia/app/pages/discount_page.dart';
import 'package:app_kaike_barbearia/app/pages/payment_page.dart';
import 'package:app_kaike_barbearia/app/pages/product_list_page.dart';
import 'package:app_kaike_barbearia/app/template/calendar.dart';
import 'package:app_kaike_barbearia/app/utils/content_message.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/snackbar.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<Map<String, dynamic>> items = [];
  double discount = 0, subtotal = 0, total = 0, profitTotal = 0;

  changeValueAfterQuantityIncrement(int index) {
    var item = items[index];
    setState(() {
      if (item["quantity"] == 999) return;
      item["quantity"]++;
      calculateSubTotalAndSubProfitByItems(
          items[index]["quantity"], items[index]["sale_value"], index);
    });
  }

  changeValueAfterQuantityDecrease(int index) {
    setState(() {
      if (items[index]["quantity"] == 1) return;
      items[index]["quantity"]--;
      calculateSubTotalAndSubProfitByItems(
          items[index]["quantity"], items[index]["sale_value"], index);
    });
  }

  calculateSubTotalAndSubProfitByItems(int quantity, double price, int index) {
    double profit = items[index]["profit_value"];
    items[index]["subtotal"] = quantity * price;
    items[index]["sub_profit_value"] = quantity * profit;
    calculateSubTotalAndProfitTotal();
  }

  calculateSubTotalAndProfitTotal() {
    subtotal = 0;
    profitTotal = 0;
    setState(() {
      for (var item in items) {
        subtotal += item["subtotal"];
        profitTotal += item["sub_profit_value"];
      }
    });
    if (items.isEmpty || discount > subtotal) {
      discount = 0;
    }
    calculateTotal();
  }

  calculateTotal() {
    setState(() {
      total = subtotal - discount;
    });
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Venda"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Calendar(),
                    Container(
                      color: Colors.indigo.withOpacity(.1),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              final itemsSelected =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProductListPage(
                                    itFromTheSalesScreen: true,
                                  ),
                                ),
                              );

                              if (itemsSelected != null) {
                                setState(() {
                                  items.add(itemsSelected);
                                });
                                calculateSubTotalAndProfitTotal();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  top: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Adicionar Produto",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: heightScreen - 400,
                            ),
                            child: ListView.separated(
                              itemBuilder: (_, index) {
                                final item = items[index];
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (_) async {
                                          items.removeAt(index);
                                          setState(() {
                                            calculateSubTotalAndProfitTotal();
                                          });
                                        },
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete_outline,
                                        label: "Excluir",
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    horizontalTitleGap: 0,
                                    minVerticalPadding: 0,
                                    leading: const Icon(
                                      FontAwesomeIcons.box,
                                      color: Color.fromARGB(255, 105, 123, 223),
                                    ),
                                    title: Text(
                                      item["name"],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      "${item["quantity"].toString()}x ${numberFormat.format(item["subtotal"])}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    trailing: SizedBox(
                                      width: 127,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () =>
                                                changeValueAfterQuantityDecrease(
                                                    index),
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                              size: 30,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          Container(
                                            width: 31,
                                            alignment: Alignment.center,
                                            child: Text(
                                              item["quantity"].toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                changeValueAfterQuantityIncrement(
                                                    index),
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              size: 30,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: items.length,
                              separatorBuilder: (_, index) => Divider(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.indigo.withOpacity(.1),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        top: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (items.isEmpty) {
                          showMessage(
                            const ContentMessage(
                              icon: FontAwesomeIcons.circleExclamation,
                              title:
                                  "Adicione ou crie um produto para aplicar um desconto.",
                            ),
                            Colors.orange,
                          );
                          return;
                        }
                        final money = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DiscountPage(
                              subtotal: subtotal,
                              discount: discount,
                            ),
                          ),
                        );

                        if (money != null) {
                          setState(() {
                            discount = money;
                          });
                          calculateSubTotalAndProfitTotal();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Desconto",
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(
                            Icons.add,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Subtotal",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              numberFormat.format(subtotal),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Desconto",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              numberFormat.format(-discount),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              numberFormat.format(total),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (items.isEmpty) {
                                showMessage(
                                  const ContentMessage(
                                    title:
                                        "Selecione ou crie um produto para a venda.",
                                    icon: FontAwesomeIcons.circleExclamation,
                                  ),
                                  Colors.orange,
                                );
                                return;
                              }

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PaymentPage(total: total),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Continuar",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
