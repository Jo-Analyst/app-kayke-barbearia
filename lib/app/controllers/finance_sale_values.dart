import '../utils/get_list_payment.dart';
import 'finance_controller.dart';

class FinanceSaleValue {
  List<Map<String, dynamic>> itemsSales = [];
  List<Map<String, dynamic>> itemsPaymentsSales = [];
  double valueTotalSale = 0;

  loadValues(String monthAndYear) async {
    valueTotalSale = await FinanceController(monthAndYear: monthAndYear)
        .getSumSalesbyMonthAndYear();
    itemsSales =
        await FinanceController(monthAndYear: monthAndYear).getListSales();
    final listPaymentsSales =
        await FinanceController(monthAndYear: monthAndYear)
            .getListPaymentsSales();
    itemsPaymentsSales = getListPayments(listPaymentsSales);
  }
}
