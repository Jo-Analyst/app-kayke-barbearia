import '../models/personal_expense_balance_model.dart';

class PersonalExpenseBalanceController {
  final String? dateInitial;
  final String? dateFinal;
  final String? monthAndYear;

  PersonalExpenseBalanceController({
    this.dateInitial,
    this.dateFinal,
    this.monthAndYear,
  });

  Future<List<Map<String, dynamic>>> getListPersonalExpenses() async {
    return PersonalExpenseBalanceModel(monthAndYear: monthAndYear)
        .getListPersonalExpenses();
  }

  Future<List<Map<String, dynamic>>> getListPersonalExpensesByPeriod() async {
    return PersonalExpenseBalanceModel(
            dateInitial: dateInitial, dateFinal: dateFinal)
        .getListPersonalExpensesByPeriod();
  }
}
