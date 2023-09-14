import '../config/db.dart';

class ExpenseBalanceModel {
  final String? dateInitial;
  final String? dateFinal;
  final String? monthAndYear;

  ExpenseBalanceModel({
    this.dateInitial,
    this.dateFinal,
    this.monthAndYear,
  });

  Future<List<Map<String, dynamic>>> getListExpenses() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT expenses.name_product, SUM(expenses.quantity) AS quantity, SUM(expenses.price) * quantity AS price FROM expenses WHERE expenses.date LIKE '%$monthAndYear%' GROUP BY expenses.name_product");
  }

  Future<List<Map<String, dynamic>>> getListExpensesByPeriod() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT expenses.name_product, SUM(expenses.quantity) AS quantity, SUM(expenses.price) * quantity AS price FROM expenses WHERE expenses.date BETWEEN '$dateInitial' AND '$dateFinal' GROUP BY expenses.name_product");
  }
}
