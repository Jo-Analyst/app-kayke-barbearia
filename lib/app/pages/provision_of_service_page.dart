import 'package:app_kayke_barbearia/app/pages/discount_page.dart';
import 'package:app_kayke_barbearia/app/pages/payment_page.dart';
import 'package:app_kayke_barbearia/app/pages/service_list_page.dart';
import 'package:app_kayke_barbearia/app/template/calendar.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/snackbar.dart';

class ProvisionOfServicePage extends StatefulWidget {
  const ProvisionOfServicePage({super.key});

  @override
  State<ProvisionOfServicePage> createState() => _ProvisionOfServicePageState();
}

class _ProvisionOfServicePageState extends State<ProvisionOfServicePage> {
  List<Map<String, dynamic>> items = [];
  double discount = 0, subtotal = 0, total = 0, profitTotal = 0;
  DateTime dateSelected = DateTime.now();

  calculateSubTotal() {
    subtotal = 0;
    setState(() {
      for (var item in items) {
        subtotal += item["price_service"];
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

  showTime(int index) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(items[index]["time_service"].toString().split(":")[0]),
        minute:
            int.parse(items[index]["time_service"].toString().split(":")[1]),
      ),
    );

    if (time != null) {
      setState(() {
        items[index]["time_service"] = time.toString().substring(10, 15);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Prestação de Serviço"),
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
                                  builder: (_) => const ServiceListPage(
                                    itFromTheSalesScreen: true,
                                  ),
                                ),
                              );

                              if (itemsSelected != null) {
                                setState(() {
                                  itemsSelected.runtimeType.toString() ==
                                          "List<Map<String, dynamic>>"
                                      ? items.addAll(itemsSelected)
                                      : items.add(itemsSelected);
                                });

                                calculateSubTotal();
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
                                    "Adicionar serviço",
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
                                              items.removeAt(index);
                                              setState(() {
                                                calculateSubTotal();
                                              });
                                            },
                                            backgroundColor: Colors.red,
                                            icon: Icons.delete_outline,
                                            label: "Excluir",
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        minVerticalPadding: 0,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              numberFormat.format(
                                                  item["price_service"]),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          item["description"] ?? "",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Hor.: ${item["time_service"]}",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: SizedBox(
                                          width: 127,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              onPressed: () => showTime(index),
                                              icon: Icon(
                                                Icons.more_time_sharp,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 35,
                                              ),
                                            ),
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
                                  "Adicione ou crie um serviço para aplicar um desconto.",
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
                          calculateSubTotal();
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
                                        "Selecione ou crie um serviço para continuar.",
                                    icon: FontAwesomeIcons.circleExclamation,
                                  ),
                                  Colors.orange,
                                );
                                return;
                              }

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PaymentPage(
                                    items: items,
                                    discount: discount,
                                    total: total,
                                    date: dateSelected,
                                    isSale: false,
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
