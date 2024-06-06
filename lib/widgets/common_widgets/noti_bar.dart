


import 'package:flutter/material.dart';

SnackBar notiBar(String message, bool isError, { String? labelAction, void Function()? pressed, int duration = 500}) {
  return SnackBar(content: Text(message), backgroundColor: isError ? Colors.red : Colors.green, action:
  labelAction != null ?
  SnackBarAction(
    label: 'Undo',
    onPressed: pressed ?? () {},
  ) : null,
  duration: Duration(milliseconds: duration),
  );
}