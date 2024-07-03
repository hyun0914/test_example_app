import 'package:flutter/material.dart';

void showSnackBarView ({
  required BuildContext context,
  required String snackBarMessage
}) {
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(
    SnackBar(content: Text(snackBarMessage)),
  );
}