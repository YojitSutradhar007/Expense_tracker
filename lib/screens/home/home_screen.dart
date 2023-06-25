import 'package:expense_tracker_dev/models/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/widgets.dart';
import '../add_expense/add_expense_screen.dart';
import 'package:expense_tracker_dev/data/expense_data.dart';
import 'package:expense_tracker_dev/resources/resources.dart';
import 'components/components.dart';

final ValueNotifier<int> len = ValueNotifier(ExpenseData.expData.length);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final Size _size=
  final WarningBar _bar = WarningBar();
  late final _removed = _bar.snack("Expense Removed", ColorManager.rgbWhiteBlueColor);

  double _sum = 0;
  double _leisure = 0;
  double _food = 0;
  double _work = 0;
  double _travel = 0;

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
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   print(timeStamp);
    //   print("Debug");
    // });
    removeExpense();

    SchedulerBinding.instance.endOfFrame.then((value) {
      print("EndOfFrame");
    });
  }

  @override
  Widget build(BuildContext context) {
    final double sizeWidth = MediaQuery.of(context).size.width;
    final double sizeHeight = MediaQuery.of(context).size.height;
    print("SizeWidth:$sizeWidth ");
    print("SizeHeight:$sizeHeight ");

    debugPrint("first build");
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
            child: sizeWidth > 400
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                            const GraphIcon(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: len,
                          builder: (context, value, child) {
                            return value == 0
                                ? noExpense()
                                : ListView.builder(
                                    padding: const EdgeInsets.only(top: 10, bottom: 80).r,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemCount: value,
                                    itemBuilder: (context, index) {
                                      return ExpenseListBuilder(
                                        onDismissed: (dismissed) {
                                          ScaffoldMessenger.of(context).clearSnackBars();
                                          ScaffoldMessenger.of(context).showSnackBar(_removed);
                                          ExpenseData.expData.remove(ExpenseData.expData[index]);
                                          removeExpense();
                                          setState(() {});
                                          len.value = ExpenseData.expData.length;
                                        },
                                        index: index,
                                      );
                                    },
                                  );
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
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
                      const GraphIcon(),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: len,
                          builder: (context, value, child) {
                            return value == 0
                                ? noExpense()
                                : ListView.builder(
                                    padding: const EdgeInsets.only(top: 10, bottom: 80).r,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: value,
                                    itemBuilder: (context, index) {
                                      return ExpenseListBuilder(
                                        onDismissed: (dismissed) {
                                          ScaffoldMessenger.of(context).clearSnackBars();
                                          ScaffoldMessenger.of(context).showSnackBar(_removed);
                                          ExpenseData.expData.remove(ExpenseData.expData[index]);
                                          removeExpense();
                                          setState(() {});
                                          len.value = ExpenseData.expData.length;
                                        },
                                        index: index,
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

Center noExpense() {
  return Center(
    child: Text(
      "No Expense data",
      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
    ),
  );
}


class GraphIcon extends StatelessWidget {
  const GraphIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
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
    );
  }
}


