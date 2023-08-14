import 'package:blurry/blurry.dart';
import 'package:flutter/material.dart';

class DialogFactory {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future showProgressIndicator<T>() {
    return showDialog<void>(
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Por favor, aguarde.',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          content: const Padding(
            padding: EdgeInsets.all(10.0),
            child: LinearProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  static void disposeProgressIndicator() {
    Navigator.of(navigatorKey.currentState!.overlay!.context).pop();
  }

  static void showToastMessage(String text) {
    Blurry(
        icon: Icons.info,
        themeColor: Colors.black,
        title: 'Algo Correu Mal 😥',
        buttonTextStyle: const TextStyle(color: Colors.black),
        description: text,
        confirmButtonText: 'OK',
        dismissable: false,
        displayCancelButton: false,
        onConfirmButtonPressed: () =>
            Navigator.pop(navigatorKey.currentState!.overlay!.context)).show(
      navigatorKey.currentState!.overlay!.context,
    );
  }
}
