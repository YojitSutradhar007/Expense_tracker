import 'package:flutter/material.dart';
import '../models/add_expense.dart';

  Map<Categories,IconData> icons={
    Categories.leisure:Icons.free_breakfast_outlined,
    Categories.food:Icons.food_bank_sharp,
    Categories.work:Icons.work_history_outlined,
    Categories.travel:Icons.travel_explore,
  };

class ExpenseData {
  static List<AddExpense> expData = [
    AddExpense(
        title: "Snacks",
        amount: 44.0,
        date: DateTime.now(),
        category: Categories.leisure),
    AddExpense(
        title: "Petrol",
        amount: 150.0,
        date: DateTime.utc(1944, 6, 6),
        category: Categories.work),
    // AddExpense(
    //     title: "Petrol",
    //     amount: 99.0,
    //     date: DateTime.utc(1944, 6, 6),
    //     category: Categories.work),
    AddExpense(
        title: "outing",
        amount: 23.0,
        date: DateTime.utc(2020, 6, 6),
        category: Categories.travel),
    // AddExpense(
    //     title: "Dinner",
    //     amount: 99.0,
    //     date: DateTime.utc(4578, 6, 6),
    //     category: Categories.food),
    AddExpense(
        title: "Dinner",
        amount: 150.0,
        date: DateTime.utc(4578, 6, 6),
        category: Categories.food),

  ];
}
