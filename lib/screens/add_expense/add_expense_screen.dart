import 'package:expense_tracker_dev/data/expense_data.dart';
import 'package:expense_tracker_dev/models/add_expense.dart';
import 'package:expense_tracker_dev/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/widgets.dart';
import '../home/home_screen.dart';

// ignore: must_be_immutable
class AddNewExpense extends StatelessWidget {
  AddNewExpense({super.key});

  final TextEditingController _expenseCtrl = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  Categories _categories = Categories.food;
  DateTime? picked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
      child: Column(
        children: [
          PrimaryTextField(
            textEditingController: _expenseCtrl,
            labelText: "Expense",
            hintText: "Add Expense",
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.w,
            ),
            child: PrimaryTextField(
              maxLength: 10,
              prefixText: "₹\t",
              textEditingController: _amountController,
              labelText: "Amount",
              hintText: "Add Amount",
              keyboardType: TextInputType.number,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 5.w,
                  ),
                  child: PrimaryTextField(
                    readOnly: true,
                    textEditingController: _dateController,
                    hintText: "Date",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                    onPressed: () {
                      showDate(context);
                    },
                    icon: const Icon(Icons.calendar_month_sharp)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: "Select a category",
                contentPadding: EdgeInsets.all(13.w),
                focusedBorder: buildOutlineInputBorder(),
                enabledBorder: buildOutlineInputBorder(),
              ),
              items: Categories.values
                  .map(
                    (category) => DropdownMenuItem(
                      enabled: true,
                      value: category,
                      child: Text(
                        category.name.toUpperCase(),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                _categories = value;
              },
            ),
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.blackColor.withOpacity(0.9),
                  elevation: 2
                ),

                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel",style: TextStyle(color: ColorManager.rgbWhiteColor),),
              ),
              SizedBox(width: 25.w,),
              ElevatedButton(
                onPressed: () {
                  ExpenseData.expData.add(
                    AddExpense(
                        title: _expenseCtrl.text.trim(),
                        amount: double.tryParse(_amountController.text.trim())!,
                        date: picked!,
                        category: _categories),
                  );
                  len.value = ExpenseData.expData.length;
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.rgbWhiteColor,
                    elevation: 2

                ),
                child: const Text(
                  "Save Expense",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<DateTime?> showDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(2000);
    picked = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);
    _dateController.text = picked.toString().split(" ")[0];
    return picked;
  }
}
