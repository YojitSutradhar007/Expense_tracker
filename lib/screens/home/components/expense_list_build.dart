import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:expense_tracker_dev/data/expense_data.dart';
import 'package:expense_tracker_dev/resources/resources.dart';


class ExpenseListBuilder extends StatelessWidget {
  const ExpenseListBuilder({
    super.key,
    required this.onDismissed,
    required this.index,
  });

  final void Function(DismissDirection)? onDismissed;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: onDismissed,
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
              boxShadow: [BoxShadow(color: ColorManager.greyColor.withOpacity(0.4), blurRadius: 4)]),
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
  }
}
