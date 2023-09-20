import 'package:app_kayke_barbearia/app/controllers/items_sale.controller.dart';
import 'package:app_kayke_barbearia/app/utils/convert_datetime.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class DetailsSale extends StatefulWidget {
  final dynamic list;
  const DetailsSale({
    required this.list,
    super.key,
  });

  @override
  State<DetailsSale> createState() => _DetailsSaleState();
}

class _DetailsSaleState extends State<DetailsSale> {
  bool expanded = false;
  List<Map<String, dynamic>> itemsSale = [];

  @override
  void initState() {
    super.initState();
    loadItemsSale();
  }

  loadItemsSale() async {
    itemsSale =
        await ItemsSaleController.getItemsSaleBySaleId(widget.list["id"]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venda - ${widget.list["id"].toString().padLeft(5, "0")}"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.indigo.withOpacity(.1),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: ListTile(
                leading: Text(
                  numberFormat.format(widget.list["value_total"]),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.list["client_name"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      changeTheDateWriting(widget.list["date"]),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Vendas",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              expanded = !expanded;
                            });
                          },
                          icon: Icon(
                            expanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    if (expanded)
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: itemsSale.length,
                          itemBuilder: (_, index) {
                            var item = itemsSale[index];
                            return ListTile(
                              title: Text(
                                item["name"],
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
