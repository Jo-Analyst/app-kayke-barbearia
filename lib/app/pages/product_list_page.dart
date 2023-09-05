import 'package:app_kaike_barbearia/app/pages/product_form_page.dart';
import 'package:app_kaike_barbearia/app/template/add_product.dart';
import 'package:app_kaike_barbearia/app/utils/content_message.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:app_kaike_barbearia/app/utils/dialog.dart';
import 'package:app_kaike_barbearia/app/utils/search_list.dart';
import 'package:app_kaike_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const ProductListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false;
  List<Map<String, dynamic>> filteredList = [];
  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Gel Azul",
      "sale_value": 20.00,
      "cost_value": 8.50,
      "profit_value": 11.50,
      "quantity": 10
    },
    {
      "id": 2,
      "name": "Gel preto",
      "sale_value": 20.00,
      "cost_value": 8.50,
      "profit_value": 11.50,
      "quantity": 10
    },
    {
      "id": 3,
      "name": "Gilete",
      "sale_value": 13.50,
      "cost_value": 5.25,
      "profit_value": 8.25,
      "quantity": 10
    },
    {
      "id": 4,
      "name": "Maquina de barbear",
      "sale_value": 100.00,
      "cost_value": 50.50,
      "profit_value": 49.50,
      "quantity": 10
    },
  ];

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  @override
  void initState() {
    super.initState();
    filteredList = products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProductFormPage(
                    isEdition: false,
                  ),
                ),
              ),
              icon: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          height: MediaQuery.of(context).size.height - 140,
          child: Column(
            children: [
              TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Digite para buscar",
                  suffixIcon: search.isEmpty
                      ? const Icon(
                          Icons.search,
                        )
                      : IconButton(
                          onPressed: () {
                            searchController.text = "";
                            setState(() {
                              search = "";
                              filteredList = products;
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                    filteredList = searchItems(value, products, false);
                  });
                },
              ),
              filteredList.isEmpty
                  ? const Center(
                      child: AddNewProduct(),
                    )
                  : Expanded(
                    child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredList.length,
                              itemBuilder: (_, index) {
                                var product = filteredList[index];
                                return Column(
                                  children: [
                                    Slidable(
                                      endActionPane: widget.itFromTheSalesScreen
                                          ? null
                                          : ActionPane(
                                              motion: const StretchMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (_) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            ProductFormPage(
                                                          isEdition: true,
                                                          productId:
                                                              product["id"],
                                                          name: product["name"],
                                                          saleValue: product[
                                                              "sale_value"],
                                                          costValue: product[
                                                              "cost_value"],
                                                          profitValue: product[
                                                              "profit_value"],
                                                          quantity:
                                                              product["quantity"],
                                                          observation: product[
                                                              "observation"],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  backgroundColor: Colors.amber,
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.edit_outlined,
                                                  label: "Editar",
                                                ),
                                                SlidableAction(
                                                  onPressed: (_) async {
                                                    final confirmDelete =
                                                        await showExitDialog(
                                                            context,
                                                            "Deseja mesmo excluir o produto '${product["name"]}'?");
                                                    if (confirmDelete!) {
                                                      products.removeAt(index);
                                                      setState(() {});
                                                      showMessage(
                                                        const ContentMessage(
                                                          title:
                                                              "Produto excluido com sucesso.",
                                                          icon: Icons.info,
                                                        ),
                                                        const Color.fromARGB(
                                                            255, 199, 82, 74),
                                                      );
                                                    }
                                                  },
                                                  backgroundColor: Colors.red,
                                                  icon: Icons.delete,
                                                  label: "Excluir",
                                                ),
                                              ],
                                            ),
                                      child: ListTile(
                                        onTap: widget.itFromTheSalesScreen
                                            ? () => Navigator.of(context).pop({
                                                  "product_id": product["id"],
                                                  "name": product["name"],
                                                  "quantity": 1,
                                                  "profit_value":
                                                      product["profit_value"],
                                                  "sub_profit_value":
                                                      product["profit_value"],
                                                  "sale_value":
                                                      product["sale_value"],
                                                  "subtotal":
                                                      product["sale_value"]
                                                })
                                            : null,
                                        selectedTileColor: Colors.indigo,
                                        title: Text(
                                          product["name"],
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        trailing: Text(
                                          "${product["quantity"]}x",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        leading: CircleAvatar(
                                          maxRadius: 40,
                                          backgroundColor: Colors.indigo,
                                          foregroundColor: Colors.white,
                                          child: Text(
                                            numberFormat
                                                .format(product["sale_value"]),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                );
                              },
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
