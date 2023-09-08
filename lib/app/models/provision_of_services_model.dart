import 'package:app_kaike_barbearia/app/config/db.dart';
import 'package:app_kaike_barbearia/app/models/items_service_model.dart';
import 'package:app_kaike_barbearia/app/models/payment_service_model.dart';

class Sale {
  final int id;
  final String dateService;
  final String timeService;
  final double valueTotal;
  final double discount;
  final int? clientId;

  Sale({
    required this.id,
    required this.dateService,
    required this.timeService,
    required this.valueTotal,
    required this.discount,
    this.clientId,
  });

  Future<int> save(List<Map<String, dynamic>> itemsSale,
      Map<String, dynamic> paymentSale) async {
    final db = await DB.openDatabase();
    int lastId = 0;
    await db.transaction((txn) async {
      if (id == 0) {
        lastId = await txn.insert("provision_of_services", {
          "date_service": dateService,
          "time_service": timeService,
          "value_total": valueTotal,
          "discount": discount,
          "client_id": clientId ?? 0
        });
      } else {
        await txn.update(
            "provision_of_services",
            {
              "date_service": dateService,
              "time_service": timeService,
              "value_total": valueTotal,
              "discount": discount,
              "client_id": clientId ?? 0
            },
            where: "id = ?",
            whereArgs: [id]);
      }

      for (var itemSale in itemsSale) {
        itemSale["provision_of_service_id"] = lastId;
        await ItemsService().save(txn, itemSale);
      }

      await PaymentService(
        id: paymentSale["id"] ?? 0,
        specie: paymentSale["specie"],
        amountPaid: paymentSale["amount_paid"],
        datePayment: dateService,
        provisionOfServiceId: lastId,
      ).save(txn);
    });

    return lastId;
  }
}
