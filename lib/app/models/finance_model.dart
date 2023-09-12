import 'package:app_kayke_barbearia/app/config/db.dart';

class Finance {
  final String? dateInitial;
  final String? dateFinal;
  final String? monthAndYear;
  Finance({
    this.dateInitial,
    this.dateFinal,
    this.monthAndYear,
  });

  Future<double> sumSalesbyMonthAndYear() async {
    final db = await DB.openDatabase();
    final list = await db.rawQuery(
      "SELECT SUM(value_total) AS value_total FROM sales WHERE date_sale LIKE '%$monthAndYear%'",
    );

    return list[0]["value_total"] != null
        ? list[0]["value_total"] as double
        : 0.0;
  }

   Future<List<Map<String, dynamic>>> getListSales() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT products.name, SUM(items_sales.quantity) AS quantity_items, SUM(items_sales.sub_total) AS subtotal FROM items_sales INNER JOIN sales ON sales.id = items_sales.sale_id INNER JOIN products ON products.id = items_sales.product_id WHERE sales.date_sale LIKE '%$monthAndYear%' GROUP BY products.name");
  }
   Future<List<Map<String, dynamic>>> getListPaymentsSales() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT payments_sales.specie, SUM(payments_sales.amount_paid)  AS value, COUNT(payments_sales.id) AS quantity FROM payments_sales WHERE payments_sales.date_payment LIKE '%$monthAndYear%' GROUP BY payments_sales.specie");
  }
}
