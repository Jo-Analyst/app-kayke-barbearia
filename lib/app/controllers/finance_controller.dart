import '../models/finance_model.dart';

class FinanceController {
  final String? monthAndYear;
  final String? dateInitial;
  final String? dateFinal;
  FinanceController({
    this.monthAndYear,
    this.dateInitial,
    this.dateFinal,
  });
  Future<double> getSumSalesbyMonthAndYear() async {
    return Finance(monthAndYear: monthAndYear).sumSalesbyMonthAndYear();
  }

  Future<List<Map<String, dynamic>>> getListSales() async {
    return Finance(monthAndYear: monthAndYear).getListSales();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsSales() async {
    return Finance(monthAndYear: monthAndYear).getListPaymentsSales();
  }

  Future<double> getSumSalesbyMonthAndYearByPeriod() async {
   
    return Finance(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).sumSalesbyMonthAndYearByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListSalesByPeriod() async {
    return Finance(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListSalesByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsSalesByPeriod() async {
    return Finance(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPaymentsSalesByPeriod();
  }
}
