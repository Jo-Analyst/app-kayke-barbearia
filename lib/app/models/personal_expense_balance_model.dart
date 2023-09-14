import '../config/db.dart';

class PersonalExpenseBalanceModel {
  final String? dateInitial;
  final String? dateFinal;
  final String? monthAndYear;

  PersonalExpenseBalanceModel({
    this.dateInitial,
    this.dateFinal,
    this.monthAndYear,
  });

  Future<List<Map<String, dynamic>>> getListPersonalExpenses() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT personal_expenses.name_product, SUM(personal_expenses.quantity) AS quantity, SUM(personal_expenses.price) * quantity AS price FROM personal_expenses WHERE personal_expenses.date LIKE '%$monthAndYear%' GROUP BY personal_expenses.name_product");
  }

  Future<List<Map<String, dynamic>>> getListPersonalExpensesByPeriod() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT personal_expenses.name_product, SUM(personal_expenses.quantity) AS quantity, SUM(personal_expenses.price) * quantity AS price FROM personal_expenses WHERE personal_expenses.date BETWEEN '$dateInitial' AND '$dateFinal' GROUP BY personal_expenses.name_product");
  }
}
