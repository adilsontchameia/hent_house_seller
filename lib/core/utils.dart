
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

  void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  String formatDateTime(DateTime date) {
    String formattedDate = DateFormat('HH:mm / yyyy-MM-dd').format(date);
    return formattedDate;
  }

  

