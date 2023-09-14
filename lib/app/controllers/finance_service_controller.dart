import 'package:app_kayke_barbearia/app/models/finance_service_model.dart';

class FinanceServiceController {
  final String? monthAndYear;
  final String? dateInitial;
  final String? dateFinal;

  FinanceServiceController({
    this.monthAndYear,
    this.dateInitial,
    this.dateFinal,
  });

  Future<double> getSumServicesbyMonthAndYear() async {
    return FinanceServiceModel(monthAndYear: monthAndYear).sumServicesbyMonthAndYear();
  }

  Future<List<Map<String, dynamic>>> getListServices() async {
    return FinanceServiceModel(monthAndYear: monthAndYear).getListServices();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsServices() async {
    return FinanceServiceModel(monthAndYear: monthAndYear).getListPaymentsServices();
  }

  Future<double> getSumServicesbyMonthAndYearByPeriod() async {
   
    return FinanceServiceModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).sumServicesbyMonthAndYearByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListServicesByPeriod() async {
    return FinanceServiceModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListServicesByPeriod();
  }

  Future<List<Map<String, dynamic>>> getListPaymentsServicesByPeriod() async {
    return FinanceServiceModel(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPaymentsServicesByPeriod();
  }
}
