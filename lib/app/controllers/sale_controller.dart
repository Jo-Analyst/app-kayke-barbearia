import 'package:app_kayke_barbearia/app/models/sale_model.dart';

class SaleController {
  Future<List<Map<String, dynamic>>> getSalesByDate(String date) async {    
    return await Sale.findByDate(date);
  }
}
