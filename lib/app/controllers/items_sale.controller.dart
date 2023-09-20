import 'package:app_kayke_barbearia/app/models/items_sale.dart';

class ItemsSaleController {
  static Future<List<Map<String, dynamic>>> getItemsSaleBySaleId(
      int saleId) async {
    return await ItemsSale().findBySaleId(saleId);
  }
}
