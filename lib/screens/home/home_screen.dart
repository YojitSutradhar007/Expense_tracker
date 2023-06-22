import 'package:expense_tracker_dev/models/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/widgets.dart';
import '../add_expense/add_expense_screen.dart';
import 'package:expense_tracker_dev/data/expense_data.dart';
import 'package:expense_tracker_dev/resources/resources.dart';

final ValueNotifier<int> len = ValueNotifier(ExpenseData.expData.length);

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WarningBar _bar = WarningBar();
  late final _removed = _bar.snack("Expense Removed", ColorManager.rgbWhiteBlueColor);

  double _sum = 0;
  double _leisure = 0;
  double _food = 0;
  double _work = 0;
  double _travel = 0;

  void totalExpense() {
    for (int i = 0; i < ExpenseData.expData.length; i++) {
      if (Categories.food == ExpenseData.expData[i].category) {
        _food += ExpenseData.expData[i].amount;
      } else if (Categories.leisure == ExpenseData.expData[i].category) {
        _leisure += ExpenseData.expData[i].amount;
      } else if (Categories.work == ExpenseData.expData[i].category) {
        _work += ExpenseData.expData[i].amount;
      } else if (Categories.travel == ExpenseData.expData[i].category) {
        _travel += ExpenseData.expData[i].amount;
      }
    }
    print(_sum);
  }

  void removeExpense() {
    for (int i = 0; i < ExpenseData.expData.length; i++) {
      _sum += ExpenseData.expData[i].amount;
    }
    _food = ExpenseList(category: Categories.food, expenses: ExpenseData.expData).totalExpense();
    _travel = ExpenseList(category: Categories.travel, expenses: ExpenseData.expData).totalExpense();
    _work = ExpenseList(category: Categories.work, expenses: ExpenseData.expData).totalExpense();
    _leisure = ExpenseList(category: Categories.leisure, expenses: ExpenseData.expData).totalExpense();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    removeExpense();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
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
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: SizedBox(
                    height: 120.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ExpenseChart(totalExpense: _leisure, sum: _sum),
                        ExpenseChart(totalExpense: _food, sum: _sum),
                        ExpenseChart(totalExpense: _work, sum: _sum),
                        ExpenseChart(totalExpense: _travel, sum: _sum),
                      ],
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.free_breakfast_outlined,
                      size: 30,
                    ),
                    Icon(
                      Icons.food_bank_sharp,
                      size: 30,
                    ),
                    Icon(
                      Icons.work_history_outlined,
                      size: 30,
                    ),
                    Icon(
                      Icons.travel_explore,
                      size: 30,
                    ),
                  ],
                ),
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
                                    setState(() {});

                                    len.value = ExpenseData.expData.length;
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      debugPrint("Remove Successful");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: ColorManager.whiteColor,
                                          border: Border.all(color: ColorManager.greyColor, width: 1.22.w),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(color: ColorManager.greyColor.withOpacity(0.4), blurRadius: 4)
                                          ]),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(ExpenseData.expData[index].title),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("₹\t${ExpenseData.expData[index].amount}"),
                                              Row(
                                                children: [
                                                  Icon(
                                                    icons[ExpenseData.expData[index].category],
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(ExpenseData.expData[index].date.toString().split(" ")[0])
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
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
