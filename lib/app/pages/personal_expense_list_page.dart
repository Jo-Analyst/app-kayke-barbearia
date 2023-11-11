import 'package:app_kayke_barbearia/app/models/backup.dart';
import 'package:app_kayke_barbearia/app/pages/personal_expense_form_page.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/personal_expense_provider.dart';
import '../template/add_personal_expense.dart';
import '../utils/convert_datetime.dart';
import '../utils/cache.dart';

class PersonalExpenseListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const PersonalExpenseListPage(
      {required this.itFromTheSalesScreen, super.key});

  @override
  State<PersonalExpenseListPage> createState() =>
      _PersonalExpenseListPageState();
}

class _PersonalExpenseListPageState extends State<PersonalExpenseListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false, isLoading = true;
  List<Map<String, dynamic>> personalExpenses = [];

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color, 3000);
  }

  @override
  void initState() {
    super.initState();
    loadPersonalExpenses();
  }

  void loadPersonalExpenses() async {
    final personalExpenseProvider =
        Provider.of<PersonalExpenseProvider>(context, listen: false);
    await personalExpenseProvider.load();
    setState(() {
      personalExpenses = personalExpenseProvider.items;

      isLoading = false;
    });
  }

  void deletePersonalExpense(PersonalExpenseProvider personalExpenseProvider,
      Map<String, dynamic> personalExpense) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final confirmDelete =
        await showExitDialog(context, "Deseja mesmo excluir?");
    if (confirmDelete == true) {
      personalExpenseProvider.delete(personalExpense["id"]);
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
        title: const Text("Despesas pessoais"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PersonalExpenseFormPage(
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
          : Consumer<PersonalExpenseProvider>(
              builder: (context, personalExpenseProvider, _) {
                personalExpenses = personalExpenseProvider.items;
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
                                        loadPersonalExpenses();
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              search = value;
                              personalExpenseProvider.searchName(value);
                            });
                          },
                        ),
                        personalExpenses.isEmpty
                            ? Center(
                                child: AddNewPersonalExpense(
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
                                        itemCount: personalExpenses.length,
                                        itemBuilder: (_, index) {
                                          var personalExpense =
                                              personalExpenses[index];

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
                                                                              PersonalExpenseFormPage(
                                                                        isEdition:
                                                                            true,
                                                                        personalExpenseId:
                                                                            personalExpense["id"],
                                                                        nameProduct:
                                                                            personalExpense["name_product"],
                                                                        price: personalExpense[
                                                                            "price"],
                                                                        quantity:
                                                                            personalExpense["quantity"],
                                                                        date: convertStringToDateTime(
                                                                            personalExpense["date"]),
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
                                                                  deletePersonalExpense(
                                                                      personalExpenseProvider,
                                                                      personalExpense);
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
                                                    personalExpense[
                                                        "name_product"],
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                  subtitle: Text(
                                                    "${personalExpense["quantity"]}x ${numberFormat.format(personalExpense["price"])} = ${numberFormat.format(personalExpense["subtotal"])}",
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  trailing: Text(
                                                    changeTheDateWriting(
                                                        personalExpense[
                                                            "date"]),
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
