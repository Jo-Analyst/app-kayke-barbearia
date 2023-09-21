import 'package:app_kayke_barbearia/app/models/sale_model.dart';

class SaleController {
  static Future<List<Map<String, dynamic>>> getSalesByDate(String date) async {
    return await Sale.findByDate(date);
  }

  static void deleteSale(int id, List<Map<String, dynamic>> itemsSale) async {
    await Sale.delete(id, itemsSale);
  }

  static void updateClientAndDate(int saleId, Map<String, dynamic> data) async {
    await Sale.updateClientAndDate(data, saleId);
  }
}
