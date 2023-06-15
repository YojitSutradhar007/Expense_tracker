import 'package:uuid/uuid.dart';

enum Categories { food, travel, leisure, work }

const uuid = Uuid();

class AddExpense {
  AddExpense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String? id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;
}
