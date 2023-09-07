class PaymentSale {
  final int id;
  final String specie;
  final double amountPaid;
  final String date;
  final int saleId;

  PaymentSale({
    required this.id,
    required this.specie,
    required this.amountPaid,
    required this.date,
    required this.saleId,
  });

  void save() async {}
}
