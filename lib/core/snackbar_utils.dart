import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';


/// For showing success/error snackBar
class SnackBarUtils {
  static showSuccessSnackBar(BuildContext context, String msg) {
    context.showFlash<bool>(
        barrierDismissible: true,
        duration: const Duration(seconds: 2),
        builder: (context, controller) => flashBar(
              controller,
              msg: msg,
              color: Colors.green
            ));
  }

  static showErrorSnackBar(BuildContext context, String message) {
    context.showFlash<bool>(
        barrierDismissible: true,
        duration: const Duration(seconds: 2),
        builder: (context, controller) => flashBar(
              controller,
              msg: message,
              color: Colors.red,
            ));
  }

  ///Creating flash-bar
  static FlashBar<bool> flashBar(FlashController<bool> controller,
      {required String msg, required Color color}) {
    return FlashBar(
      backgroundColor: color,
      controller: controller,
      forwardAnimationCurve: Curves.easeInCirc,
      reverseAnimationCurve: Curves.bounceInOut,
      position: FlashPosition.bottom,
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle( color:Colors.white,
          fontSize: 14,),
      ),
    );
  }
}
