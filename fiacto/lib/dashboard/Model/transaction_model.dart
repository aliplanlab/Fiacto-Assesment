
class TransactionModel {
  final String name;
  final String transferType;
  final String amount;
  final String date;

  TransactionModel({
    required this.name,
    required this.transferType,
    required this.amount,
    required this.date,
  });

  static List<TransactionModel> transactions = [
    TransactionModel(
      name: 'Olivia Brown',
      transferType: 'Incoming Transfer',
      amount: '+\$120.00',
      date: 'May 28,2025',
    ),
    TransactionModel(
      name: 'Liam Johnson',
      transferType: 'Outgoing Transfer',
      amount: '+\$120.00',
      date: 'May 28,2025',
    ),
    TransactionModel(
      name: 'Emma Thompson',
      transferType: 'Incoming Transfer',
      amount: '+\$120.00',
      date: 'May 28,2025',
    ),
    TransactionModel(
      name: 'Noah Smith',
      transferType: 'Outgoing Transfer',
      amount: '+\$120.00',
      date: 'May 28,2025',
    ),
  ];
}
