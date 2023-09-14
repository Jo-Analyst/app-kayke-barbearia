import '../utils/get_list_payment.dart';
import 'finance_service_controller.dart';

class FinancesServicesValues {
  List<Map<String, dynamic>> itemsServices = [];
  List<Map<String, dynamic>> itemsPaymentsServices = [];
  double valueTotal = 0, valuePaid = 0, valueReceivable = 0;

  loadValuesByDate(String monthAndYear) async {
    valueTotal = await FinanceServiceController(monthAndYear: monthAndYear)
        .getSumServicesbyMonthAndYear();

    itemsServices =
        await FinanceServiceController(monthAndYear: monthAndYear).getListServices();

    final listPaymentsSales =
        await FinanceServiceController(monthAndYear: monthAndYear)
            .getListPaymentsServices();

    itemsPaymentsServices = getListPayments(listPaymentsSales);

    sumValuesPaid();
    calcValueReceivable();
  }

  loadValuesByPeriod(String dateInitial, String dateFinal) async {
    valueTotal = await FinanceServiceController(
            dateInitial: dateInitial, dateFinal: dateFinal)
        .getSumServicesbyMonthAndYearByPeriod();

    itemsServices = await FinanceServiceController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListServicesByPeriod();

    final listPaymentsSales = await FinanceServiceController(
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
