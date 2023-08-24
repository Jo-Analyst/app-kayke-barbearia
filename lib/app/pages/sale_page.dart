import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<Map<String, dynamic>> products = [
    {"name": "Gel Azul", "quantity": 1, "price": 20.00},
    {"name": "Pomada trim", "quantity": 1, "price": 15.35},
    {"name": "Máquina de barbear", "quantity": 1, "price": 100.00},
    {"name": "Gel Azul", "quantity": 1, "price": 20.00},
    {"name": "Pomada trim", "quantity": 1, "price": 15.35},
    {"name": "Máquina de barbear", "quantity": 1, "price": 100.00},
    {"name": "Gel Azul", "quantity": 1, "price": 20.00},
    {"name": "Pomada trim", "quantity": 1, "price": 15.35},
    {"name": "Máquina de barbear", "quantity": 1, "price": 100.00},
    {"name": "Gel Azul", "quantity": 1, "price": 20.00},
    {"name": "Pomada trim", "quantity": 1, "price": 15.35},
    {"name": "Máquina de barbear", "quantity": 1, "price": 100.00},
    {"name": "Gel Azul", "quantity": 1, "price": 20.00},
    {"name": "Pomada trim", "quantity": 1, "price": 15.35},
    {"name": "Máquina de barbear", "quantity": 1, "price": 100.00},
    {"name": "Gel Azul", "quantity": 1, "price": 20.00},
    {"name": "Pomada trim", "quantity": 1, "price": 15.35},
    {"name": "Máquina de barbear", "quantity": 1, "price": 100.00},
  ];
  double discount = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Venda"),
      ),
      body: Container(
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
                          onPressed: () {},
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
                      maxHeight: MediaQuery.of(context).size.height - 360,
                    ),
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        final product = products[index];
                        return ListTile(
                          horizontalTitleGap: 0,
                          minVerticalPadding: 0,
                          leading: const Icon(
                            FontAwesomeIcons.box,
                            // size: 18,
                            color: Color.fromARGB(255, 105, 123, 223),
                          ),
                          title: Text(
                            product["name"],
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            "${product["quantity"].toString()}x ${numberFormat.format(product["price"])}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: SizedBox(
                            width: 160,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  product["quantity"].toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return Divider(color: Theme.of(context).primaryColor);
                      },
                      itemCount: products.length,
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
                          onPressed: () {},
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
                              numberFormat.format(4000),
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
                                numberFormat.format(-400),
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
                              numberFormat.format(3600),
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
          ],
        ),
      ),
    );
  }
}
