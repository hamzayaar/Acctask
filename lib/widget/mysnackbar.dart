import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    borderRadius: 10,
    margin: EdgeInsets.all(10),
    colorText: Colors.white,
    duration: Duration(seconds: 4),
    isDismissible: true,  
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
    overlayBlur:1.0,

  );
}
