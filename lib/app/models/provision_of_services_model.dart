import 'package:app_kayke_barbearia/app/config/db.dart';
import 'package:app_kayke_barbearia/app/models/items_service_model.dart';
import 'package:app_kayke_barbearia/app/models/payment_service_model.dart';

class ProvisionOfService {
  final int id;
  final String dateService;
  final double valueTotal;
  final double discount;
  final int? clientId;

  ProvisionOfService({
    required this.id,
    required this.dateService,
    required this.valueTotal,
    required this.discount,
    this.clientId,
  });

  Future<int> save(List<Map<String, dynamic>> itemsService,
      Map<String, dynamic> paymentService) async {
    final db = await DB.openDatabase();
    int lastId = 0;
    await db.transaction((txn) async {
      if (id == 0) {
        lastId = await txn.insert("provision_of_services", {
          "date_service": dateService,
          "value_total": valueTotal,
          "discount": discount,
          "client_id": clientId ?? 0
        });
      } else {
        await txn.update(
            "provision_of_services",
            {
              "date_service": dateService,
              "value_total": valueTotal,
              "discount": discount,
              "client_id": clientId ?? 0
            },
            where: "id = ?",
            whereArgs: [id]);
      }

      for (var itemService in itemsService) {
        itemService.remove("description");
        itemService["provision_of_service_id"] = lastId;
        await ItemsService().save(txn, itemService);
      }

      await PaymentService(
        id: paymentService["id"] ?? 0,
        specie: paymentService["specie"],
        amountPaid: paymentService["amount_paid"],
        datePayment: dateService,
        provisionOfServiceId: lastId,
      ).save(txn);
    });

    return lastId;
  }
}
