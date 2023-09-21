import 'package:app_kayke_barbearia/app/config/db.dart';
import 'package:sqflite/sqflite.dart';

class ItemsService {
  Future<void> save(Transaction txn, Map<String, dynamic> itemsService) async {
    await txn.insert("items_services", itemsService);
  }

  Future<List<Map<String, dynamic>>> findByProvisionOfServiceId(
      int provisionOfServiceId) async {
    final db = await DB.openDatabase();
    return db.rawQuery(
        "SELECT services.description, items_services.price_service, items_services.time_service FROM items_services INNER JOIN services ON services.id = items_services.service_id  WHERE provision_of_service_id = ?",
        [provisionOfServiceId]);
  }

  static void deleteByProvisionOfServiceId(Transaction txn, int saleId) async {
    txn.delete("items_services", where: "provision_of_service_id = ?", whereArgs: [saleId]);
  }
}
