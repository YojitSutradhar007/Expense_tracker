import 'dart:async';
import 'package:expense_tracker_dev/data/expense_data.dart';
import 'package:expense_tracker_dev/models/add_expense.dart';
import 'package:expense_tracker_dev/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/widgets.dart';
import '../home/home_screen.dart';

// ignore: must_be_immutable
class AddNewExpense extends StatefulWidget {
  AddNewExpense({super.key});

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> with SingleTickerProviderStateMixin {
  final TextEditingController _expenseCtrl = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  Categories? _categories;
  DateTime? picked;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<Offset> _animation = Tween<Offset>(
    end: const Offset(0, 0),
    begin: const Offset(0, 5),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate,
    ),
  );

  @override
  void initState() {
    super.initState();
    // _animationController.addListener(
    //   () {
    //     print("animation on going");
    //   },
    // );
    _animationController.addStatusListener(
      (status) {
        print(status);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _expenseCtrl.dispose();
    _amountController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Container(
      color: ColorManager.whiteColor,
      padding: const EdgeInsets.fromLTRB(15, 45, 15, 15).w,
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
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: ColorManager.blackColor.withOpacity(0.9), elevation: 2),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: ColorManager.rgbWhiteColor),
                ),
              ),
              SizedBox(
                width: 25.w,
              ),
              ElevatedButton(
                onLongPress: () {
                  //for debug processing
                  ExpenseData.expData.add(
                    AddExpense(
                        title: "Dinner", amount: 99.5, date: DateTime.utc(4578, 6, 6), category: Categories.food),
                  );
                  len.value = ExpenseData.expData.length;
                  Navigator.pop(context);
                  setState(() {});
                },
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(backgroundColor: ColorManager.rgbWhiteColor, elevation: 2),
                child: const Text(
                  "Save Expense",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          const Spacer(),
          SlideTransition(
            position: _animation,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13.r),
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [
                  BoxShadow(
                    color: ColorManager.greyColor,
                    blurRadius: 7,
                    offset: Offset(0, 5),
                  )
                ],
                gradient: const LinearGradient(
                  colors: [ColorManager.rgbWhiteBlueColor, ColorManager.rgbWhiteColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Plz Enter all Fields',
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onPressed() {
    if (_expenseCtrl.text.trim().isEmpty ||
        _amountController.text.trim().isEmpty ||
        _dateController.text.trim().isEmpty ||
        _categories == null) {
      debugPrint("Invalid");
      _animationController.forward().then(
        (value) {
          Future.delayed(
            const Duration(milliseconds: 800),
            () {
              _animationController.reverse();
            },
          );
        },
      );
    } else {
      ExpenseData.expData.add(
        AddExpense(
            title: _expenseCtrl.text.trim(),
            amount: double.tryParse(_amountController.text.trim())!,
            date: picked!,
            category: _categories!),
      );
      Navigator.pop(context);
      setState(() {});
    }
    len.value = ExpenseData.expData.length;
  }

  Future<DateTime?> showDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(2000);
    picked = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);
    _dateController.text = picked.toString().split(" ")[0];
    return picked;
  }
}
