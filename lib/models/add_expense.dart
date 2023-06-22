import 'package:uuid/uuid.dart';
import '../data/expense_data.dart';

enum Categories { food, travel, leisure, work }

const uuid = Uuid();

class AddExpense {
  AddExpense({required this.title, required this.amount, required this.date, required this.category}) : id = uuid.v4();
  final String? id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;
}

class ExpenseList {
  ExpenseList({
    required this.category,
    required this.expenses,
  });

  final Categories category;
  final List<AddExpense> expenses;
  double sum=0;
  double count=0;


  totalExpense(){
    for (int i = 0; i < ExpenseData.expData.length; i++) {
      sum += ExpenseData.expData[i].amount;
    }
    for (int i = 0; i < ExpenseData.expData.length; i++) {
      if(category==ExpenseData.expData[i].category){
        count+=ExpenseData.expData[i].amount;
      }
    }
    print(count);
    return count;
  }
}
