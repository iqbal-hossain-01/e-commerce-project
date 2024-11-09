import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showSnackBar(BuildContext context, String msg, {Duration duration = const Duration(seconds: 2), VoidCallback? onPressed}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      backgroundColor: Theme.of(context).primaryColorDark, // Custom background color
      duration: duration, // Custom duration
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for a smoother look
      ),
      behavior: SnackBarBehavior.floating, // Floating snack bar for better visibility
      margin: const EdgeInsets.all(16), // Adds margin around the snack bar
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Adds padding for better spacing
      action: SnackBarAction(
        label: 'OK', // A simple action button
        textColor: Colors.white,
        onPressed: onPressed!
      ),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorSize = 50.0
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
    //..textStyle = const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blueGrey);
}
