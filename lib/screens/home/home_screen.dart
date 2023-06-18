import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/widgets.dart';
import '../add_expense/add_expense_screen.dart';
import 'package:expense_tracker_dev/data/expense_data.dart';
import 'package:expense_tracker_dev/resources/resources.dart';

final ValueNotifier<int> len = ValueNotifier(ExpenseData.expData.length);

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final WarningBar _bar = WarningBar();
  late final _removed = _bar.snack("Expense Removed", ColorManager.rgbWhiteBlueColor);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                      return value == 0
                          ? Center(
                              child: Text(
                                "No Expense data",
                                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 10, bottom: 80).r,
                              physics: const BouncingScrollPhysics(),
                              itemCount: value,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (dismissed) {
                                    ScaffoldMessenger.of(context).clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(_removed);
                                    ExpenseData.expData.remove(ExpenseData.expData[index]);
                                    len.value = ExpenseData.expData.length;
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      debugPrint("Remove Successful");
                                    },
                                    child: Container(
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
                                              Text("₹\t${ExpenseData.expData[index].amount}"),
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
                                    ),
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
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: ColorManager.whiteColor,
              context: context,
              builder: (ctx) {
                return AddNewExpense();
              },
            );
          },
          child: const Icon(Icons.add, color: ColorManager.blackColor),
        ),
      ),
    );
  }
}
