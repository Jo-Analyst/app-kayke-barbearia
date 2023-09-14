import 'package:app_kayke_barbearia/app/controllers/expense_balance_controller.dart';

class ExpenseBalanceValues {
  List<Map<String, dynamic>> itemsExpense = [];
  double valueTotal = 0;

  loadValuesByDate(String monthAndYear) async {
    valueTotal = 0;
    itemsExpense = await ExpenseBalanceController(
      monthAndYear: monthAndYear,
    ).getListExpenses();
    
    for (var item in itemsExpense) {
      valueTotal += item["price"];
    }
  }

  loadValuesByPeriod(String dateInitial, String dateFinal) async {
    itemsExpense = await ExpenseBalanceController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListExpensesByPeriod();

    valueTotal = 0;
    for (var item in itemsExpense) {
      valueTotal += item["price"];
    }
  }
}
