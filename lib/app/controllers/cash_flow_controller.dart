import 'package:app_kaike_barbearia/app/models/cash_flow_model.dart';

import '../utils/convert_values.dart';

class CashFlowController {
  static Future<double> getSumTotalSalesByDate(DateTime dateSelected) async {
    double valueTotalSale =
        await CashFlow(date:  dateFormat1.format(dateSelected)).sumTotalSalesByDate();
    return valueTotalSale;
  }

  static Future<double> getSumTotalServicesByDate(DateTime dateSelected) async {
    double valueTotalService =
        await CashFlow(date:  dateFormat1.format(dateSelected)).sumTotalServicesByDate();
    return valueTotalService;
  }

  static Future<List<Map<String, dynamic>>> getSumValuesSalesBySpecie(
      DateTime dateSelected) async {
    return CashFlow(date:  dateFormat1.format(dateSelected)).sumValuesSalesBySpecie();
  }

  static Future<List<Map<String, dynamic>>> getSumValuesServicesBySpecie(
      DateTime dateSelected) async {
    return CashFlow(date:  dateFormat1.format(dateSelected)).sumValuesServicesBySpecie();
  }
  static Future<List<Map<String, dynamic>>> getListSales(DateTime dateSelected) async {
    return CashFlow(date:  dateFormat1.format(dateSelected)).getListSales();
  }
  static Future<List<Map<String, dynamic>>> getListServices(DateTime dateSelected) async {
    return CashFlow(date:  dateFormat1.format(dateSelected)).getListServices();
  }
}
