import 'package:flutter/material.dart';

void showErrorMessage(String message, BuildContext context) {
  final snackBar =
      SnackBar(content: Text(message, style: TextStyle(color: Colors.red)));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessMessage(String message, BuildContext context) {
  final snackBar =
      SnackBar(content: Text(message, style: TextStyle(color: Colors.green)));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
