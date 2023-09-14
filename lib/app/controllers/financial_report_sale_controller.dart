import '../models/financial_report_sale_model.dart';

class FinancialReportSaleController {
  final String? monthAndYear;
  final String? dateInitial;
  final String? dateFinal;
  FinancialReportSaleController({
    this.monthAndYear,
    this.dateInitial,
    this.dateFinal,
  });
  Future<double> getSumSalesbyMonthAndYear() async {
    return FinancialReportSaleModel(monthAndYear: monthAndYear).sumSalesbyMonthAndYear();
  }

  Future<List<Map<String, dynamic>>> getListSales() async {
    return FinancialReportSaleModel(monthAndYear: monthAndYear).getListSales();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsSales() async {
    return FinancialReportSaleModel(monthAndYear: monthAndYear).getListPaymentsSales();
  }

  Future<double> getSumSalesbyMonthAndYearByPeriod() async {
   
    return FinancialReportSaleModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).sumSalesbyMonthAndYearByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListSalesByPeriod() async {
    return FinancialReportSaleModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListSalesByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsSalesByPeriod() async {
    return FinancialReportSaleModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPaymentsSalesByPeriod();
  }
}
