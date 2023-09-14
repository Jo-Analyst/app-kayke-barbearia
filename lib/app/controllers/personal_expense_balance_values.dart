import 'package:app_kayke_barbearia/app/controllers/personal_expense_balance_controller.dart';

class PersonalExpenseBalanceValues {
  List<Map<String, dynamic>> itemsPersonalExpense = [];
  double valueTotal = 0;

  loadValuesByDate(String monthAndYear) async {
    valueTotal = 0;
    itemsPersonalExpense = await PersonalExpenseBalanceController(
      monthAndYear: monthAndYear,
    ).getListPersonalExpenses();
    
    for (var item in itemsPersonalExpense) {
      valueTotal += item["price"];
    }
  }

  loadValuesByPeriod(String dateInitial, String dateFinal) async {
    itemsPersonalExpense = await PersonalExpenseBalanceController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPersonalExpensesByPeriod();

    valueTotal = 0;
    for (var item in itemsPersonalExpense) {
      valueTotal += item["price"];
    }
  }
}
