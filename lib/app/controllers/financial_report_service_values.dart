import '../utils/get_list_payment.dart';
import 'financial_report_service_controller.dart';

class FinancialReportServicesValues {
  List<Map<String, dynamic>> itemsServices = [];
  List<Map<String, dynamic>> itemsPaymentsServices = [];
  double valueTotal = 0, valuePaid = 0, valueTotalDicount = 0;

  loadValuesByDate(String monthAndYear) async {
    final provisionOfServices =
        await FinancialReportServiceController(monthAndYear: monthAndYear)
            .getSumServicesbyMonthAndYear();
    valueTotal = provisionOfServices[0]["value_total"];
    valueTotalDicount = provisionOfServices[0]["discount"];

    itemsServices =
        await FinancialReportServiceController(monthAndYear: monthAndYear)
            .getListServices();

    final listPaymentsSales =
        await FinancialReportServiceController(monthAndYear: monthAndYear)
            .getListPaymentsServices();

    itemsPaymentsServices = getListPayments(listPaymentsSales);

    sumValuesPaid();
  }

  loadValuesByPeriod(String dateInitial, String dateFinal) async {
    final provisionOfServices = await FinancialReportServiceController(
            dateInitial: dateInitial, dateFinal: dateFinal)
        .getSumServicesbyMonthAndYearByPeriod();
    valueTotal = provisionOfServices[0]["value_total"];
    valueTotalDicount = provisionOfServices[0]["discount"];

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
  }

  sumValuesPaid() {
    valuePaid = 0;
    for (var itemPaymentSale in itemsPaymentsServices) {
      valuePaid += itemPaymentSale["value"];
    }
  }
}
