import '../models/finance_model.dart';

class FinanceController {
  final String monthAndYear;
  FinanceController({
    required this.monthAndYear,
  });
  Future<double> getSumSalesbyMonthAndYear() async {
    return Finance(monthAndYear: monthAndYear).sumSalesbyMonthAndYear();
  }

  Future<List<Map<String, dynamic>>> getListSales() async {
    return Finance(monthAndYear: monthAndYear).getListSales();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsSales() async {
    print(await Finance(monthAndYear: monthAndYear).getListPaymentsSales());
    return Finance(monthAndYear: monthAndYear).getListPaymentsSales();
  }
}
