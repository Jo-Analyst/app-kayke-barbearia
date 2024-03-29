import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/pages/expense/expense_form_page.dart';
import 'package:app_kayke_barbearia/app/providers/expense_provider.dart';
import 'package:app_kayke_barbearia/app/pages/expense/components/add_expense.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../utils/convert_datetime.dart';
import '../../utils/cache.dart';

class ExpenseListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const ExpenseListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false, isLoading = true;
  List<Map<String, dynamic>> expenses = [];

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 3000);
  }

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  void loadExpenses() async {
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    await expenseProvider.load();
    setState(() {
      expenses = expenseProvider.items;
      isLoading = false;
    });
  }

  void deleteExpense(
      ExpenseProvider expenseProvider, Map<String, dynamic> expense) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final confirmDelete =
        await showExitDialog(context, "Deseja mesmo excluir?");
    if (confirmDelete == true) {
      expenseProvider.delete(expense["id"]);
      await Backup.toGenerate();
      showMessage(
        const ContentMessage(
          title: "Despesa excluida com sucesso.",
          icon: Icons.info,
        ),
        const Color.fromARGB(255, 199, 82, 74),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ExpenseFormPage(
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
          : Consumer<ExpenseProvider>(
              builder: (context, expenseProvider, _) {
                expenses = expenseProvider.items;
                return SingleChildScrollView(
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
                          focusNode: textFocusNode,
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
                                        loadExpenses();
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              search = value;
                              expenseProvider.searchName(value);
                            });
                          },
                        ),
                        expenses.isEmpty
                            ? Center(
                                child: AddNewExpense(
                                  closeKeyboard: () => FocusScope.of(context)
                                      .requestFocus(FocusNode()),
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: expenses.length,
                                        itemBuilder: (_, index) {
                                          var expense = expenses[index];
                                          return Column(
                                            children: [
                                              Slidable(
                                                endActionPane:
                                                    widget.itFromTheSalesScreen
                                                        ? null
                                                        : ActionPane(
                                                            motion:
                                                                const StretchMotion(),
                                                            children: [
                                                              SlidableAction(
                                                                onPressed: (_) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          FocusNode());
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                              ExpenseFormPage(
                                                                        isEdition:
                                                                            true,
                                                                        expenseId:
                                                                            expense["id"],
                                                                        nameProduct:
                                                                            expense["name_product"],
                                                                        price: expense[
                                                                            "price"],
                                                                        quantity:
                                                                            expense["quantity"],
                                                                        date: convertStringToDateTime(
                                                                            expense["date"]),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                backgroundColor:
                                                                    Colors
                                                                        .amber,
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                icon: Icons
                                                                    .edit_outlined,
                                                                label: "Editar",
                                                              ),
                                                              SlidableAction(
                                                                onPressed: (_) {
                                                                  deleteExpense(
                                                                      expenseProvider,
                                                                      expense);
                                                                },
                                                                backgroundColor:
                                                                    Colors.red,
                                                                icon: Icons
                                                                    .delete,
                                                                label:
                                                                    "Excluir",
                                                              ),
                                                            ],
                                                          ),
                                                child: ListTile(
                                                  minLeadingWidth: 0,
                                                  selectedTileColor:
                                                      Colors.indigo,
                                                  title: Text(
                                                    expense["name_product"],
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                  subtitle: Text(
                                                    "${expense["quantity"]}x ${numberFormat.format(expense["price"])} = ${numberFormat.format(expense["subtotal"])}",
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  trailing: Text(
                                                    changeTheDateWriting(
                                                        expense["date"]),
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
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
                  ),
                );
              },
            ),
    );
  }
}
