import 'package:chat_app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UiUtils {
  static void showLoading(BuildContext context, [List<Widget>? children]) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children ?? [CircularProgressIndicator()],
                ),
              ),
            ),
          );
        },
      );

  static void showSuccessMessage(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: AppTheme.green,
    textColor: AppTheme.white,
  );
  static void showErrorMessage(String? message) => Fluttertoast.showToast(
    msg: message ?? "Something Went Wrong",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: AppTheme.red,
    textColor: AppTheme.white,
  );
}
