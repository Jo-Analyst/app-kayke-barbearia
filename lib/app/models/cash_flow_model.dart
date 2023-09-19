import 'package:app_kayke_barbearia/app/config/db.dart';

class CashFlow {
  final String date;

  CashFlow({
    required this.date,
  });

  Future<dynamic> sumTotalSalesByDate() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT SUM(value_total) AS value_total, SUM(discount) AS discount FROM sales WHERE date_sale = ? ",
        [date]);
  }

  Future<dynamic> sumTotalServicesByDate() async {
    final db = await DB.openDatabase();
    return await db.rawQuery(
        "SELECT SUM(value_total) AS value_total,  SUM(discount) AS discount FROM provision_of_services WHERE date_service = ? ",
        [date]);
  }

  Future<List<Map<String, dynamic>>> sumValuesSalesBySpecie() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT specie, SUM(amount_paid) AS value FROM payments_sales INNER JOIN sales ON sales.id = payments_sales.sale_id WHERE date_sale = ? GROUP BY specie",
        [date]);
  }

  Future<List<Map<String, dynamic>>> sumValuesServicesBySpecie() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT specie, SUM(amount_paid) AS value FROM payments_services INNER JOIN provision_of_services ON provision_of_services.id = payments_services.provision_of_service_id WHERE date_service = ? GROUP BY specie",
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
