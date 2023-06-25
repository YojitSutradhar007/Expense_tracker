
import 'package:flutter/material.dart';
import 'package:expense_tracker_dev/resources/resources.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({
    super.key,
    required double totalExpense,
    required double sum,
  })  : _totalExpense = totalExpense,
        _sum = sum;

  final double _totalExpense;
  final double _sum;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: _totalExpense / _sum,
        widthFactor: 0.5,
        child: Container(
          decoration: const BoxDecoration(
            color: ColorManager.rgbWhiteBlueColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
