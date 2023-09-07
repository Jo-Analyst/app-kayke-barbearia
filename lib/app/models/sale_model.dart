class Sale {
  final int id;
  final String dateSale;
  final double profitValueTotal;
  final double discount;
  final int clientId;

  Sale({
    required this.id,
    required this.dateSale,
    required this.profitValueTotal,
    required this.discount,
    required this.clientId,
  });

  void save(List<Map<String, dynamic>> itemsSales,
      Map<String, dynamic> paymentSale) async {}
}
