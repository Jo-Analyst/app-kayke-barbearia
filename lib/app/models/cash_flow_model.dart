import 'package:app_kaike_barbearia/app/config/db.dart';

class CashFlow {
  final String dateSelected;

  CashFlow({
    required this.dateSelected,
  });

  Future<dynamic> sumTotalSalesByDate() async {
    final db = await DB.openDatabase();
    final sales = await db.rawQuery(
        "SELECT SUM(value_total) as total_sale FROM sales WHERE date_sale = ? ",
        [dateSelected]);

    return sales[0]["total_sale"] ?? 0.00;
  }

  Future<dynamic> sumTotalServicesByDate() async {
    final db = await DB.openDatabase();
    final service = await db.rawQuery(
        "SELECT SUM(value_total) as total_sale FROM provision_of_services WHERE date_service = ? ",
        [dateSelected]);
        
    return service[0]["total_sale"] ?? 0.00;
  }
}
