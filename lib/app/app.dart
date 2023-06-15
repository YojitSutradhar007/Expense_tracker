import 'package:expense_tracker_dev/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/resources.dart';

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          theme: ThemeData(
            useMaterial3: true,
            /*colorScheme: ColorScheme(onPrimary:, brightness: null,
                primary: null,
                secondary: null,
                onSecondary: null,
                error: null,
                onError: null,
                background: null,
                onBackground: null,
                surface: null,
                onSurface: null),*/
            primaryColor: ColorManager.rgbWhiteColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              color: Color.fromRGBO(236, 242, 254, 1),

            ),
            scaffoldBackgroundColor: ColorManager.whiteColor,
            fontFamily: "CrimsonText",
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
        );
      },
    );
  }
}
