class ItemsSale {
  final int id;
  final int quantityItems;
  final double subTotal;
  final double priceProduct;
  final double profitProduct;
  final int productId;
  final int saleId;

  ItemsSale({
    required this.id,
    required this.quantityItems,
    required this.subTotal,
    required this.priceProduct,
    required this.profitProduct,
    required this.productId,
    required this.saleId,
  });

  void save()async {

  }
}
