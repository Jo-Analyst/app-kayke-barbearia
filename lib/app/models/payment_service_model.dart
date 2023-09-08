import 'package:sqflite/sqflite.dart';

class PaymentService {
  final int id;
  final String specie;
  final double amountPaid;
  final String datePayment;
  final int provisionOfServiceId;

  PaymentService({
    required this.id,
    required this.specie,
    required this.amountPaid,
    required this.datePayment,
    required this.provisionOfServiceId,
  });

  Future<void> save(Transaction txn) async {
    await txn.insert("payments_services", {
      "specie": specie,
      "amount_paid": amountPaid,
      "date_payment": datePayment,
      "provision_of_service_id": provisionOfServiceId
    },);
  }
}
