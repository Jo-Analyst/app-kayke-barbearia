import 'package:sqflite/sqflite.dart';

class PaymentSale {
  final int id;
  final String specie;
  final double amountPaid;
  final String datePayment;
  final int saleId;

  PaymentSale({
    required this.id,
    required this.specie,
    required this.amountPaid,
    required this.datePayment,
    required this.saleId,
  });

  Future<void> save(Transaction txn) async {
    await txn.insert("payments_sales", {
      "specie": specie,
      "amount_paid": amountPaid,
      "date_payment": datePayment,
      "sale_id": saleId
    },);
  }
}
