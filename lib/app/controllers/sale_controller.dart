import 'package:app_kayke_barbearia/app/models/sale_model.dart';

class SaleController {
  static Future<List<Map<String, dynamic>>> getSalesByDate(String date) async {
    return await Sale.findByDate(date);
  }

  static deleteSale(int id, List<Map<String, dynamic>> itemsSale) async {
    await Sale.delete(id, itemsSale);
  }
}
