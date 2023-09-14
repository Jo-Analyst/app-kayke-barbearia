import '../models/finance_sale_model.dart';

class FinanceSaleController {
  final String? monthAndYear;
  final String? dateInitial;
  final String? dateFinal;
  FinanceSaleController({
    this.monthAndYear,
    this.dateInitial,
    this.dateFinal,
  });
  Future<double> getSumSalesbyMonthAndYear() async {
    return FinanceSaleModel(monthAndYear: monthAndYear).sumSalesbyMonthAndYear();
  }

  Future<List<Map<String, dynamic>>> getListSales() async {
    return FinanceSaleModel(monthAndYear: monthAndYear).getListSales();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsSales() async {
    return FinanceSaleModel(monthAndYear: monthAndYear).getListPaymentsSales();
  }

  Future<double> getSumSalesbyMonthAndYearByPeriod() async {
   
    return FinanceSaleModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).sumSalesbyMonthAndYearByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListSalesByPeriod() async {
    return FinanceSaleModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListSalesByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsSalesByPeriod() async {
    return FinanceSaleModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPaymentsSalesByPeriod();
  }
}
