import '../utils/get_list_payment.dart';
import 'financial_report_sale_controller.dart';

class FinancialReportSalesValues {
  List<Map<String, dynamic>> itemsSales = [];
  List<Map<String, dynamic>> itemsPaymentsSales = [];
  double valueTotalSale = 0, profit = 0, valuePaid = 0;

  loadValuesByDate(String monthAndYear) async {
    valueTotalSale = await FinancialReportSaleController(monthAndYear: monthAndYear)
        .getSumSalesbyMonthAndYear();

    itemsSales =
        await FinancialReportSaleController(monthAndYear: monthAndYear).getListSales();

    final listPaymentsSales =
        await FinancialReportSaleController(monthAndYear: monthAndYear)
            .getListPaymentsSales();

    itemsPaymentsSales = getListPayments(listPaymentsSales);

    sumValuesProfit();
    sumValuesPaid();
  }

  loadValuesByPeriod(String dateInitial, String dateFinal) async {
    valueTotalSale =
        await FinancialReportSaleController(dateInitial: dateInitial, dateFinal: dateFinal)
            .getSumSalesbyMonthAndYearByPeriod();

    itemsSales = await FinancialReportSaleController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListSalesByPeriod();

    final listPaymentsSales = await FinancialReportSaleController(
      dateInitial: dateInitial,
      dateFinal: dateFinal,
    ).getListPaymentsSalesByPeriod();

    itemsPaymentsSales = getListPayments(listPaymentsSales);
    sumValuesProfit();
    sumValuesPaid();
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
