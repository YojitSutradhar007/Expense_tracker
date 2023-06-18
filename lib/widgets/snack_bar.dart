import 'package:flutter/material.dart';
import '../resources/color_manager.dart';

class WarningBar {
  SnackBar snack(String warning, Color backgroundColor) {
    return SnackBar(
      duration: const Duration(milliseconds: 500),
      content: Text(
        warning,
        style: const TextStyle(color: ColorManager.blackColor, fontSize: 15, fontWeight: FontWeight.w500),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
