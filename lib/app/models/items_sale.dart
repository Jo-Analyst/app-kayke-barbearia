import 'package:sqflite/sqflite.dart';

class ItemsSale {
  // final int? id;
  // final int quantityItems;
  // final double subTotal;
  // final double subProfitTotal;
  // final double priceProduct;
  // final double profitProduct;
  // final int productId;
  // final int saleId;

  // ItemsSale({
  // this.id,
  // required this.quantityItems,
  // required this.subTotal,
  // required this.subProfitTotal,
  // required this.priceProduct,
  // required this.profitProduct,
  // required this.productId,
  // required this.saleId,
  // });

  Future<void> save(Transaction txn, Map<String, dynamic> itemsSale) async {
    await txn.insert("items_sales", itemsSale);
    // await txn.insert("items_sales", {
    // "quantity_items": quantityItems,
    // "sub_total": subTotal,
    // "price_product": priceProduct,
    // "profit_product": profitProduct,
    // "sub_profit_product": subProfitTotal,
    // "product_id": productId,
    // "sale_id": saleId,
    // });
  }
}
