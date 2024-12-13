import 'package:cabswalle/core/app_colors.dart';
import 'package:flutter/material.dart';

class SnackbarUtils {
  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  static showErrorSnackBar({required String message}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
  }

  static showSuccessSnackBar({required String message}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.myprimaryColor,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
  }

  static dismissSnackBar() {
    snackbarKey.currentState?.hideCurrentSnackBar();
  }
}
