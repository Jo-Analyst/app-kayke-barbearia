import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/pages/product/product_form_page.dart';
import 'package:app_kayke_barbearia/app/providers/product_provider.dart';
import 'package:app_kayke_barbearia/app/pages/product/components/add_product.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/cache.dart';

class ProductListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const ProductListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isLoading = true;
  bool isGranted = false;
  List<Map<String, dynamic>> filteredList = [];
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> productsSelected = [];

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 3000);
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.load();
    setState(() {
      products = productProvider.items;
      isLoading = false;
    });
  }

  void deleteProduct(ProductProvider productsProvider, product) async {
    final confirmDelete = await showExitDialog(
        context, "Deseja mesmo excluir o produto '${product["name"]}'?");
    if (confirmDelete == true) {
      productsProvider.delete(product["id"]);
      await Backup.toGenerate();
      showMessage(
        const ContentMessage(
          title: "Produto excluido com sucesso.",
          icon: Icons.info,
        ),
        const Color.fromARGB(255, 199, 82, 74),
      );
    }
  }

  void selectProducts(Map<String, dynamic> dataProduct) {
    final result = productsSelected.any(
      (product) => product["name"] == dataProduct["name"],
    );
    setState(() {
      !result
          ? productsSelected.add({
              "product_id": dataProduct["id"],
              "name": dataProduct["name"],
              "quantity_items": dataProduct["quantity"],
              "profit_product": dataProduct["profit_value"],
              "quantity": 1,
              "sub_profit_product": dataProduct["profit_value"],
              "price_product": dataProduct["sale_value"],
              "sub_total": dataProduct["sale_value"]
            })
          : productsSelected.removeWhere(
              (product) => product["name"] == dataProduct["name"],
            );
    });
  }

  void selectAllProducts() {
    setState(() {
      if (productsSelected.length == products.length) {
        productsSelected.clear();
        return;
      }

      productsSelected.clear();
      for (var product in products) {
        productsSelected.add({
          "product_id": product["id"],
          "name": product["name"],
          "quantity_items": product["quantity"],
          "profit_product": product["profit_value"],
          "quantity": 1,
          "sub_profit_product": product["profit_value"],
          "price_product": product["sale_value"],
          "sub_total": product["sale_value"]
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productsSelected.isNotEmpty
            ? productsSelected.length.toString()
            : "Produtos"),
        actions: [
          if (productsSelected.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => selectAllProducts(),
                  icon: const Icon(
                    Icons.select_all,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(productsSelected);
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                  ),
                ),
              ],
            ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProductFormPage(
                      isEdition: false,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: loading(context, 50),
            )
          : SingleChildScrollView(
              child: Consumer<ProductProvider>(
                builder: (context, productsProvider, child) {
                  products = productsProvider.items;
                  return Container(
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
                          focusNode: textFocusNode,
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
                                        loadProducts();
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              search = value;
                              productsProvider.searchName(value);
                            });
                          },
                        ),
                        products.isEmpty
                            ? Center(
                                child: AddNewProduct(
                                  closeKeyboard: () {
                                    FocusScope.of(context).requestFocus(
                                      FocusNode(),
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: products.length,
                                        itemBuilder: (_, index) {
                                          var product = products[index];
                                          return Column(
                                            children: [
                                              Slidable(
                                                endActionPane: ActionPane(
                                                  motion: const StretchMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed: (_) {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                ProductFormPage(
                                                              isEdition: true,
                                                              productId:
                                                                  product["id"],
                                                              name: product[
                                                                  "name"],
                                                              saleValue: product[
                                                                  "sale_value"],
                                                              costValue: product[
                                                                  "cost_value"],
                                                              profitValue: product[
                                                                  "profit_value"],
                                                              quantity: product[
                                                                  "quantity"],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      backgroundColor:
                                                          Colors.amber,
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.edit_outlined,
                                                      label: "Editar",
                                                    ),
                                                    SlidableAction(
                                                      onPressed: (_) async {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                        deleteProduct(
                                                          productsProvider,
                                                          product,
                                                        );
                                                      },
                                                      backgroundColor:
                                                          Colors.red,
                                                      icon: Icons.delete,
                                                      label: "Excluir",
                                                    ),
                                                  ],
                                                ),
                                                child: ListTile(
                                                  selected: productsSelected
                                                      .any((dataProduct) =>
                                                          dataProduct["name"] ==
                                                          product["name"]),
                                                  selectedColor: Colors.white,
                                                  onLongPress: widget
                                                          .itFromTheSalesScreen
                                                      ? () {
                                                          selectProducts(
                                                              product);
                                                        }
                                                      : null,
                                                  onTap: () {
                                                    if (widget
                                                            .itFromTheSalesScreen &&
                                                        productsSelected
                                                            .isEmpty) {
                                                      Navigator.of(context).pop(
                                                        {
                                                          "product_id":
                                                              product["id"],
                                                          "name":
                                                              product["name"],
                                                          "quantity_items":
                                                              product[
                                                                  "quantity"],
                                                          "quantity": 1,
                                                          "profit_product":
                                                              product[
                                                                  "profit_value"],
                                                          "sub_profit_product":
                                                              product[
                                                                  "profit_value"],
                                                          "price_product":
                                                              product[
                                                                  "sale_value"],
                                                          "sub_total": product[
                                                              "sale_value"]
                                                        },
                                                      );
                                                      return;
                                                    }

                                                    selectProducts(product);
                                                  },
                                                  minLeadingWidth: 0,
                                                  selectedTileColor:
                                                      Colors.indigo,
                                                  title: Text(
                                                    product["name"],
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  trailing: Text(
                                                    "${product["quantity"]}x",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    numberFormat.format(
                                                        product["sale_value"]),
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  leading: Icon(
                                                    FontAwesomeIcons.box,
                                                    color: productsSelected.any(
                                                            (dataProduct) =>
                                                                dataProduct[
                                                                    "name"] ==
                                                                product["name"])
                                                        ? Colors.white
                                                        : Theme.of(context)
                                                            .primaryColor,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                  );
                },
              ),
            ),
    );
  }
}
