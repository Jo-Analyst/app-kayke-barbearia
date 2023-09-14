import '../utils/get_list_payment.dart';
import 'financial_report_service_controller.dart';

class FinancialReportServicesValues {
  List<Map<String, dynamic>> itemsServices = [];
  List<Map<String, dynamic>> itemsPaymentsServices = [];
  double valueTotal = 0, valuePaid = 0, valueReceivable = 0;

  loadValuesByDate(String monthAndYear) async {
    valueTotal = await FinancialReportServiceController(monthAndYear: monthAndYear)
        .getSumServicesbyMonthAndYear();

    itemsServices =
        await FinancialReportServiceController(monthAndYear: monthAndYear).getListServices();

    final listPaymentsSales =
        await FinancialReportServiceController(monthAndYear: monthAndYear)
            .getListPaymentsServices();

    itemsPaymentsServices = getListPayments(listPaymentsSales);

    sumValuesPaid();
    calcValueReceivable();
  }

  loadValuesByPeriod(String dateInitial, String dateFinal) async {
    valueTotal = await FinancialReportServiceController(
            dateInitial: dateInitial, dateFinal: dateFinal)
        .getSumServicesbyMonthAndYearByPeriod();

    itemsServices = await FinancialReportServiceController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListServicesByPeriod();

    final listPaymentsSales = await FinancialReportServiceController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPaymentsServicesByPeriod();

    itemsPaymentsServices = getListPayments(listPaymentsSales);
    sumValuesPaid();
    calcValueReceivable();
  }

  calcValueReceivable() {
    valueReceivable = valueTotal - valuePaid;
  }

  sumValuesPaid() {
    valuePaid = 0;
    for (var itemPaymentSale in itemsPaymentsServices) {
      valuePaid += itemPaymentSale["value"];
    }
  }
}
