import 'package:flutter/material.dart';
import 'app/app.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //   (value) {
      runApp(const ExpenseTracker());
  //   },
  // );
}
