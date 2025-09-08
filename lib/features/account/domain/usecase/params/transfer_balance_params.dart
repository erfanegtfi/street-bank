class TransferBalanceParams {
  String id;
  String date;
  String? description;
  double amount;
  String? beneficiaryName;
  String accountNumber;

  TransferBalanceParams({
    required this.id,
    required this.date,
    this.description,
    required this.amount,
    required this.beneficiaryName,
    required this.accountNumber,
  });
}
