import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/ui/styles/colors.dart';

SnackbarController showMessage({
  required String message,
  required String title,
  Color? messageColor,
  Widget? icon,
  Color? background,
  int seconds = 3,
}) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: background ?? AppColors.background.withOpacity(0.8),
    colorText: messageColor,
    icon: icon,
    duration: Duration(seconds: seconds),
    snackPosition: SnackPosition.BOTTOM,
  );
}

void showSuccessMessage({
  required String message,
  String title = 'Success',
  int seconds = 3,
}) {
  showMessage(
    message: message,
    title: title,
    seconds: seconds,
    icon: const Icon(
      CupertinoIcons.check_mark_circled_solid,
      color: Colors.white,
    ),
    messageColor: Colors.white,
    background: Colors.green,
  );
}

void showWarningMessage({
  required String message,
  String title = 'Warning',
  int seconds = 3,
}) {
  showMessage(
    message: message,
    title: title,
    seconds: seconds,
    icon: Icon(
      CupertinoIcons.exclamationmark_triangle_fill,
      color: Colors.orange[700],
    ),
    messageColor: Colors.orange[700],
    background: Colors.yellow[100],
  );
}

void showInfoMessage({
  required String message,
  String title = 'Info',
  int seconds = 3,
}) =>
    showMessage(
      message: message,
      title: title,
      seconds: seconds,
      icon: Icon(
        CupertinoIcons.info_circle_fill,
        color: Colors.blue[900],
      ),
      messageColor: Colors.blue[900],
      background: Colors.blue[100],
    );

void showErrorMessage({
  required String message,
  String title = 'Error',
  int seconds = 3,
}) {
  showMessage(
    message: message,
    seconds: seconds,
    title: title,
    icon: const Icon(
      CupertinoIcons.xmark_circle_fill,
      color: Colors.white,
    ),
    messageColor: Colors.white,
    background: Colors.red,
  );
}
