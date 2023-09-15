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

  static Future<List<Map<String, dynamic>>> findByDate(String date) async {
    final db = await DB.openDatabase();
    return db.rawQuery("SELECT provision_of_services.id, provision_of_services.value_total, "
        "(SELECT SUM(amount_paid) FROM payments_services WHERE id = provision_of_services.id) AS amount_paid, "
        "CASE WHEN (provision_of_services.value_total - (SELECT SUM(amount_paid) FROM payments_services WHERE id = provision_of_services.id) = 0) "
        "THEN 'Recebido' "
        "ELSE 'A receber' "
        "END AS situation, "
        "COALESCE(clients.name, 'Cliente Avulso') AS client_name, provision_of_services.date_service AS date "
        "FROM provision_of_services LEFT JOIN clients ON clients.id = provision_of_services.client_id "
        "WHERE provision_of_services.date_service LIKE '%$date%' ORDER BY provision_of_services.date_service DESC");
  }
}
