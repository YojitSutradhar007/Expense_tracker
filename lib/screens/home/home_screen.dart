import 'package:expense_tracker_dev/data/expense_data.dart';
import 'package:expense_tracker_dev/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/add_expense.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
 final  ValueNotifier<int> len = ValueNotifier(ExpenseData.expData.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expenses",
          style: TextStyle(color: Colors.black, fontSize: 20.sp, letterSpacing: 2),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: len,
                  builder: (context, value, child) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: value,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 65.h,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ExpenseData.expData[index].title),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\$ ${ExpenseData.expData[index].amount}"),
                                  Row(
                                    children: [
                                      Icon(
                                        icons[ExpenseData.expData[index].category],
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(ExpenseData.expData[index].date.toString().split(" ")[0])
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.rgbWhiteColor,
        onPressed: () {
          ExpenseData.expData.add(
            AddExpense(title: "Dinner", amount: 99.5, date: DateTime.utc(4578, 6, 6), category: Categories.food),
          );
          len.value=ExpenseData.expData.length;
        },
        child: const Icon(Icons.add, color: ColorManager.blackColor),
      ),
    );
  }
}
