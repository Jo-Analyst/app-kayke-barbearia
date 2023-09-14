import 'package:app_kayke_barbearia/app/models/expense_balance_model.dart';

class ExpenseBalanceController {
  final String? dateInitial;
  final String? dateFinal;
  final String? monthAndYear;

  ExpenseBalanceController({
    this.dateInitial,
    this.dateFinal,
    this.monthAndYear,
  });

  Future<List<Map<String, dynamic>>> getListExpenses() async {
    return ExpenseBalanceModel(monthAndYear: monthAndYear).getListExpenses();
  }

  Future<List<Map<String, dynamic>>> getListExpensesByPeriod() async {
    return ExpenseBalanceModel(dateInitial: dateInitial, dateFinal: dateFinal)
        .getListExpensesByPeriod();
  }
}
