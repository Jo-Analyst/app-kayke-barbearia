import 'package:app_kayke_barbearia/app/models/financial_report_service_model.dart';

class FinancialReportServiceController {
  final String? monthAndYear;
  final String? dateInitial;
  final String? dateFinal;

  FinancialReportServiceController({
    this.monthAndYear,
    this.dateInitial,
    this.dateFinal,
  });

  Future<List<Map<String, dynamic>>> getSumServicesbyMonthAndYear() async {
    return FinancialReportServiceModel(monthAndYear: monthAndYear).sumServicesbyMonthAndYear();
  }

  Future<List<Map<String, dynamic>>> getListServices() async {
    return FinancialReportServiceModel(monthAndYear: monthAndYear).getListServices();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsServices() async {
    return FinancialReportServiceModel(monthAndYear: monthAndYear).getListPaymentsServices();
  }

  Future<List<Map<String, dynamic>>> getSumServicesbyMonthAndYearByPeriod() async {
   
    return FinancialReportServiceModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).sumServicesbyMonthAndYearByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListServicesByPeriod() async {
    return FinancialReportServiceModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListServicesByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsServicesByPeriod() async {
    return FinancialReportServiceModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPaymentsServicesByPeriod();
  }
}
