import 'package:app_kaike_barbearia/app/models/cash_flow_model.dart';

class CashFlowController {
  static Future<double> getSumTotalSalesByDate(String dateSelected) async {
    double valueTotalSale =
        await CashFlow(date: dateSelected).sumTotalSalesByDate();
    return valueTotalSale;
  }

  static Future<double> getSumTotalServicesByDate(String dateSelected) async {
    double valueTotalService =
        await CashFlow(date: dateSelected).sumTotalServicesByDate();
    return valueTotalService;
  }

  static Future<List<Map<String, dynamic>>> getSumValuesSalesBySpecie(
      String dateSelected) async {
    return CashFlow(date: dateSelected).sumValuesSalesBySpecie();
  }

  static Future<List<Map<String, dynamic>>> getSumValuesServicesBySpecie(
      String dateSelected) async {
    return CashFlow(date: dateSelected).sumValuesServicesBySpecie();
  }
}
