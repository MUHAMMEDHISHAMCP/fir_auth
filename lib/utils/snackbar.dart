import 'package:flutter/material.dart';

class SnackBarWidget {
  static checkFormFill(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        duration: const Duration(seconds: 3)));
  }
}
