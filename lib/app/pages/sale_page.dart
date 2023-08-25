import 'package:app_kaike_barbearia/app/pages/discount_page.dart';
import 'package:app_kaike_barbearia/app/pages/product_list_page.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<Map<String, dynamic>> products = [];
  double discount = 0, subtotal = 0, total = 0;

  changeValueAfterQuantityIncrement(int index) {
    var product = products[index];
    setState(() {
      if (product["quantity"] == 999) return;
      product["quantity"]++;
      calculateSubTotalByItems(
          products[index]["quantity"], products[index]["price"], index);
    });
  }

  changeValueAfterQuantityDecrease(int index) {
    setState(() {
      if (products[index]["quantity"] == 1) return;
      products[index]["quantity"]--;
      calculateSubTotalByItems(
          products[index]["quantity"], products[index]["price"], index);
    });
  }

  calculateSubTotalByItems(int quantitity, double price, int index) {
    products[index]["subtotal"] = quantitity * price;
    calculateSubTotal();
  }

  calculateSubTotal() {
    subtotal = 0;
    setState(() {
      for (var product in products) {
        subtotal += product["subtotal"];
      }
    });
    calculateTotal();
  }

  calculateTotal() {
    setState(() {
      total = subtotal - discount;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Venda"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 101,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                color: Colors.indigo.withOpacity(.1),
                child: Column(
                  children: [
                    Container(
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Adicionar Produto",
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () async {
                              final productsSelected =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProductListPage(
                                    itFromTheSalesScreen: true,
                                  ),
                                ),
                              );

                              if (productsSelected != null) {
                                setState(() {
                                  products.add(productsSelected);
                                });
                                calculateSubTotal();
                              }
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: heightScreen - 379,
                      ),
                      child: ListView.separated(
                        itemBuilder: (_, index) {
                          final product = products[index];
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) async {
                                    products.removeAt(index);
                                    setState(() {});
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
                                product["name"],
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                "${product["quantity"].toString()}x ${numberFormat.format(product["subtotal"])}",
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Container(
                                      width: 31,
                                      alignment: Alignment.center,
                                      child: Text(
                                        product["quantity"].toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          changeValueAfterQuantityIncrement(
                                              index),
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: products.length,
                        separatorBuilder: (_, index) => Divider(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.indigo.withOpacity(.1),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Desconto",
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (products.isEmpty) return;

                              final money = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DiscountPage(subtotal: subtotal),
                                ),
                              );

                              if (money != null) {
                                setState(() {
                                  discount = money;
                                });
                                calculateSubTotal();
                              }
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
                          Visibility(
                            visible: discount > 0,
                            child: Row(
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
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Continuar",
                                  style:
                                      TextStyle(fontSize: widthScreen * 0.04),
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
            ],
          ),
        ),
      ),
    );
  }
}
