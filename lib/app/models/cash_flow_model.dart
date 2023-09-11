import 'package:app_kayke_barbearia/app/config/db.dart';

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

  Future<List<Map<String, dynamic>>> getListSales() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT products.name, SUM(items_sales.quantity) AS quantity_items, SUM(items_sales.sub_total) AS subtotal FROM items_sales INNER JOIN sales ON sales.id = items_sales.sale_id INNER JOIN products ON products.id = items_sales.product_id WHERE sales.date_sale = ? GROUP BY products.name",
        [date]);
  }

  Future<List<Map<String, dynamic>>> getListServices() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT services.description, COUNT(services.id) AS quantity_services, SUM(items_services.price_service) AS subtotal FROM items_services INNER JOIN provision_of_services ON provision_of_services.id = items_services.provision_of_service_id INNER JOIN services ON services.id = items_services.service_id WHERE provision_of_services.date_service = ? GROUP BY services.description",
        [date]);
  }
}
