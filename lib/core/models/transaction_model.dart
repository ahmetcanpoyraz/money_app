class TransactionModel {
  String id;
  DateTime createdAt;
  bool isPayment;
  String name;
  double money;
  bool? repeatingPayment;


  TransactionModel(
      {required this.id,
        required this.createdAt,
        required this.isPayment,
        required this.name,
        required this.money,
        this.repeatingPayment,
       });
}