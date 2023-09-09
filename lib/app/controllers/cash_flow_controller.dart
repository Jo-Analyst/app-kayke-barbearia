import 'package:app_kaike_barbearia/app/models/cash_flow_model.dart';

class CashFlowController {
  static Future<double> getSumTotalSalesByDate(String dateSelected) async {
    double valueTotalSale =
        await CashFlow(dateSelected: dateSelected).sumTotalSalesByDate();
    return valueTotalSale;
  }
  
  static Future<double> getSumTotalServicesByDate(String dateSelected) async {
    double valueTotalService =
        await CashFlow(dateSelected: dateSelected).sumTotalServicesByDate();
    return valueTotalService;
  }
}
