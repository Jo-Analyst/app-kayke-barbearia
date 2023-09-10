import 'package:app_kaike_barbearia/app/config/db.dart';

class CashFlow {
  final String date;

  CashFlow({
    required this.date,
  });

  Future<dynamic> sumTotalSalesByDate() async {
    final db = await DB.openDatabase();
    final sales = await db.rawQuery(
        "SELECT SUM(value_total) as total_sale FROM sales WHERE date_sale = ? ",
        [date]);

    return sales[0]["total_sale"] ?? 0.00;
  }

  Future<dynamic> sumTotalServicesByDate() async {
    final db = await DB.openDatabase();
    final service = await db.rawQuery(
        "SELECT SUM(value_total) as total_sale FROM provision_of_services WHERE date_service = ? ",
        [date]);

    return service[0]["total_sale"] ?? 0.00;
  }

  Future<List<Map<String, dynamic>>> sumValuesSalesBySpecie() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT specie, SUM(amount_paid) AS value FROM payments_sales WHERE date_payment = ? GROUP BY specie",
        [date]);
  }

  Future<List<Map<String, dynamic>>> sumValuesServicesBySpecie() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT specie, SUM(amount_paid) AS value FROM payments_services WHERE date_payment = ? GROUP BY specie",
        [date]);
  }
}
