import '../utils/get_list_payment.dart';
import 'finance_sale_controller.dart';

class FinancesSalesValues {
  List<Map<String, dynamic>> itemsSales = [];
  List<Map<String, dynamic>> itemsPaymentsSales = [];
  double valueTotalSale = 0, profit = 0, valuePaid = 0, valueReceivable = 0;

  loadValuesByDate(String monthAndYear) async {
    valueTotalSale = await FinanceSaleController(monthAndYear: monthAndYear)
        .getSumSalesbyMonthAndYear();

    itemsSales =
        await FinanceSaleController(monthAndYear: monthAndYear).getListSales();

    final listPaymentsSales =
        await FinanceSaleController(monthAndYear: monthAndYear)
            .getListPaymentsSales();

    itemsPaymentsSales = getListPayments(listPaymentsSales);

    sumValuesProfit();
    sumValuesPaid();
    calcValueReceivable();
  }

  loadValuesByPeriod(String dateInitial, String dateFinal) async {
    valueTotalSale =
        await FinanceSaleController(dateInitial: dateInitial, dateFinal: dateFinal)
            .getSumSalesbyMonthAndYearByPeriod();

    itemsSales = await FinanceSaleController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListSalesByPeriod();

    final listPaymentsSales = await FinanceSaleController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPaymentsSalesByPeriod();

    itemsPaymentsSales = getListPayments(listPaymentsSales);
    sumValuesProfit();
    sumValuesPaid();
    calcValueReceivable();
  }

  calcValueReceivable() {
    valueReceivable = valueTotalSale - valuePaid;
  }

  sumValuesProfit() {
    profit = 0;
    for (var itemSale in itemsSales) {
      profit += itemSale["profit"];
    }
  }

  sumValuesPaid() {
    valuePaid = 0;
    for (var itemPaymentSale in itemsPaymentsSales) {
      valuePaid += itemPaymentSale["value"];
    }
  }
}
