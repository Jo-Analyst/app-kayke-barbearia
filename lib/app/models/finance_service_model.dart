import '../config/db.dart';

class FinanceServiceModel {
  final String? dateInitial;
  final String? dateFinal;
  final String? monthAndYear;

  FinanceServiceModel({
    this.dateInitial,
    this.dateFinal,
    this.monthAndYear,
  });

  Future<double> sumServicesbyMonthAndYear() async {
    final db = await DB.openDatabase();
    final list = await db.rawQuery(
      "SELECT SUM(value_total) AS value_total FROM provision_of_services WHERE date_service LIKE '%$monthAndYear%'",
    );

    return list[0]["value_total"] != null
        ? list[0]["value_total"] as double
        : 0.0;
  }

  Future<List<Map<String, dynamic>>> getListServices() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT services.description, COUNT(items_services.id) AS quantity_services, SUM(items_services.price_service) AS subtotal FROM items_services INNER JOIN provision_of_services ON provision_of_services.id = items_services.provision_of_service_id INNER JOIN services ON services.id = items_services.service_id WHERE provision_of_services.date_service LIKE '%$monthAndYear%' GROUP BY services.description");
  }

  Future<List<Map<String, dynamic>>> getListPaymentsServices() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT payments_services.specie, SUM(payments_services.amount_paid)  AS value, COUNT(payments_services.id) AS quantity FROM payments_services WHERE payments_services.date_payment LIKE '%$monthAndYear%' GROUP BY payments_services.specie");
  }

  Future<double> sumServicesbyMonthAndYearByPeriod() async {
    final db = await DB.openDatabase();
    final list = await db.rawQuery(
      "SELECT SUM(value_total) AS value_total FROM provision_of_services WHERE date_service BETWEEN '$dateInitial' AND '$dateFinal'",
    );
    return list[0]["value_total"] != null
        ? list[0]["value_total"] as double
        : 0.0;
  }

  Future<List<Map<String, dynamic>>> getListServicesByPeriod() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT services.description, COUNT(items_services.id) AS quantity_services, SUM(items_services.price_service) AS subtotal FROM items_services INNER JOIN provision_of_services ON provision_of_services.id = items_services.provision_of_service_id INNER JOIN services ON services.id = items_services.service_id WHERE provision_of_services.date_service BETWEEN '$dateInitial' AND '$dateFinal' GROUP BY services.description");
  }

  Future<List<Map<String, dynamic>>> getListPaymentsServicesByPeriod() async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT payments_services.specie, SUM(payments_services.amount_paid)  AS value, COUNT(payments_services.id) AS quantity FROM payments_services WHERE payments_services.date_payment BETWEEN '$dateInitial' AND '$dateFinal' GROUP BY payments_services.specie");
  }

}
