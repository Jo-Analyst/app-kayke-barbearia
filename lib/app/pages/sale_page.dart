import 'package:app_kayke_barbearia/app/pages/discount_page.dart';
import 'package:app_kayke_barbearia/app/pages/payment_page.dart';
import 'package:app_kayke_barbearia/app/pages/product_list_page.dart';
import 'package:app_kayke_barbearia/app/template/calendar.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
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
  List<int> quantityItems = [];
  double discount = 0, subtotal = 0, total = 0, profitTotal = 0;
  DateTime dateSelected = DateTime.now();

  void changeValueAfterQuantityIncrement(int index) {
    var item = items[index];
    var quantity = quantityItems[index];
    setState(() {
      if (item["quantity"] == quantity) return;
      item["quantity"]++;
      calculateSubTotalAndSubProfitByItems(
          items[index]["quantity"], items[index]["price_product"], index);
    });
  }

  void changeValueAfterQuantityDecrease(int index) {
    setState(() {
      if (items[index]["quantity"] == 1) return;
      items[index]["quantity"]--;
      calculateSubTotalAndSubProfitByItems(
          items[index]["quantity"], items[index]["price_product"], index);
    });
  }

  void calculateSubTotalAndSubProfitByItems(
      int quantity, double price, int index) {
    double profit = items[index]["profit_product"];
    items[index]["sub_total"] = quantity * price;
    items[index]["sub_profit_product"] = quantity * profit;

    calculateSubTotalAndProfitTotal();
  }

  void calculateSubTotalAndProfitTotal() {
    subtotal = 0;
    profitTotal = 0;
    setState(() {
      for (var item in items) {
        subtotal += item["sub_total"];
        profitTotal += item["sub_profit_product"];
      }
    });
    if (items.isEmpty || discount > subtotal) {
      discount = 0;
    }
    calculateTotal();
  }

  void calculateTotal() {
    setState(() {
      total = subtotal - discount;
    });
  }

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 3000);
  }

  bool productHasBeenAdded(int productId) {
    // produto foi adicionado?
    bool wasAdded = false;
    for (var item in items) {
      if (item["product_id"] == productId) {
        wasAdded = true;
        break;
      }
    }

    return wasAdded;
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Calendar(
                          dateInitial: dateSelected,
                          onSelected: (value) {
                            setState(() {
                              dateSelected = value;
                            });
                          }),
                    ),
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
                                  if (itemsSelected.runtimeType.toString() ==
                                      "List<Map<String, dynamic>>") {
                                    for (var itemSelected in itemsSelected) {
                                      if (!productHasBeenAdded(
                                              itemSelected["product_id"]) &&
                                          itemSelected["quantity_items"] > 0) {
                                        setState(() {
                                          items.add(itemSelected);
                                          quantityItems.add(
                                              itemSelected["quantity_items"]);
                                        });
                                      }
                                    }
                                  } else {
                                    if (productHasBeenAdded(
                                        itemsSelected["product_id"])) {
                                      showMessage(
                                        const ContentMessage(
                                          icon: FontAwesomeIcons
                                              .circleExclamation,
                                          title:
                                              "Você já foi adicionou este produto na lista.",
                                        ),
                                        Colors.orange,
                                      );
                                      return;
                                    } else if (itemsSelected[
                                            "quantity_items"] ==
                                        0) {
                                      showMessage(
                                        const ContentMessage(
                                          icon: FontAwesomeIcons
                                              .circleExclamation,
                                          title:
                                              "Este produto já foi esgotado. Atualize a quantidade na tela de produtos.",
                                        ),
                                        Colors.orange,
                                      );
                                      return;
                                    }

                                    items.add(itemsSelected);
                                    quantityItems
                                        .add(itemsSelected["quantity_items"]);
                                  }
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
                            child: ListView.builder(
                              itemBuilder: (_, index) {
                                final item = items[index];
                                return Column(
                                  children: [
                                    Slidable(
                                      endActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (_) async {
                                              items.removeWhere((i) =>
                                                  i["product_id"] ==
                                                  item["product_id"]);
                                              // items.removeAt(index);
                                              quantityItems.removeAt(index);
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
                                          color: Color.fromARGB(
                                              255, 105, 123, 223),
                                        ),
                                        title: Text(
                                          item["name"] ?? "",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Text(
                                          "${item["quantity"].toString()}x ${numberFormat.format(item["sub_total"])}",
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
                                                  style: const TextStyle(
                                                      fontSize: 18),
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
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                );
                              },
                              itemCount: items.length,
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
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
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
                                  builder: (_) => PaymentPage(
                                    profitTotal: profitTotal,
                                    discount: discount,
                                    items: items,
                                    total: total,
                                    date: dateSelected,
                                    isSale: true,
                                  ),
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
