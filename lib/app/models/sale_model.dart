import 'package:app_kayke_barbearia/app/config/db.dart';
import 'package:app_kayke_barbearia/app/models/items_sale.dart';
import 'package:app_kayke_barbearia/app/models/payment_sale_model.dart';
import 'package:app_kayke_barbearia/app/models/product_model.dart';

class Sale {
  final int id;
  final String dateSale;
  final double profitValueTotal;
  final double valueTotal;
  final double discount;
  final int? clientId;

  Sale({
    required this.id,
    required this.dateSale,
    required this.profitValueTotal,
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
        lastId = await txn.insert("sales", {
          "date_sale": dateSale,
          "profit_value_total": profitValueTotal,
          "value_total": valueTotal,
          "discount": discount,
          "client_id": clientId ?? 0
        });
      } else {
        await txn.update(
            "sales",
            {
              "date_sale": dateSale,
              "profit_value_total": profitValueTotal,
              "value_total": valueTotal,
              "discount": discount,
              "client_id": clientId ?? 0
            },
            where: "id = ?",
            whereArgs: [id]);
      }

      for (var itemSale in itemsSale) {
        itemSale["sale_id"] = lastId;
        itemSale.remove("name");
        itemSale.remove("quantity_items");
        await ItemsSale().save(txn, itemSale);
        await Product.updateQuantity(
            txn, itemSale["product_id"], itemSale["quantity"]);
      }

      await PaymentSale(
        id: paymentSale["id"] ?? 0,
        specie: paymentSale["specie"],
        amountPaid: paymentSale["amount_paid"],
        datePayment: dateSale,
        saleId: lastId,
      ).save(txn);
    });

    return lastId;
  }

  static Future<List<Map<String, dynamic>>> findByDate(String date) async {
    final db = await DB.openDatabase();
    return db.rawQuery("SELECT sales.id, sales.value_total, sales.discount, "
        "(SELECT SUM(amount_paid) FROM payments_sales WHERE sale_id = sales.id) AS amount_paid, "
        "CASE WHEN (sales.value_total - (SELECT SUM(amount_paid) FROM payments_sales WHERE sale_id = sales.id) = 0) "
        "THEN 'Recebido' "
        "ELSE 'A receber' "
        "END AS situation, "
        "COALESCE(clients.name, 'Cliente Avulso') AS client_name, sales.date_sale AS date "
        "FROM sales LEFT JOIN clients ON clients.id = sales.client_id "
        "WHERE sales.date_sale LIKE '%$date%' ORDER BY sales.date_sale DESC");
  }
}
