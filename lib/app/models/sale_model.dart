import 'package:app_kaike_barbearia/app/config/db.dart';
import 'package:app_kaike_barbearia/app/models/items_sale.dart';
import 'package:app_kaike_barbearia/app/models/payment_sale_model.dart';

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
          "discount_total": discount,
          "client_id": clientId ?? 0
        });
      } else {
        await txn.update(
            "sales",
            {
              "date_sale": dateSale,
              "profit_value_total": profitValueTotal,
              "value_total": valueTotal,
              "discount_total": discount,
              "client_id": clientId ?? 0
            },
            where: "id = ?",
            whereArgs: [id]);
      }

      for (var itemSale in itemsSale) {
        itemSale["sale_id"] = lastId;
        await ItemsSale(
                // quantityItems: itemSale["quantity"],
                // subTotal: itemSale["sub_total"],
                // priceProduct: itemSale["sale_value"],
                // profitProduct: itemSale["profit_product"],
                // subProfitTotal: itemSale["sub_profit_product"],
                // productId: itemSale["product_id"],
                // saleId: lastId,
                )
            .save(txn, itemSale);
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
}
