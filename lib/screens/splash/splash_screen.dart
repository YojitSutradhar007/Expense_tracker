import 'package:expense_tracker_dev/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate;
  }

  void get navigate {
    Duration duration = const Duration(seconds: 3);
    Future.delayed(
      duration,
      () {
        context.go("/HomeScreen");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0).w,
          child: Column(
            children: [
              Lottie.asset(
                Animations.splashAnimation,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10).w,
                child: Text(
                  "Expense Tracker",
                  style: TextStyle(fontSize: 25.sp, fontFamily: "BrunoAce"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
