import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
    {required String message,
    bool isError = false,
    bool isInformation = true}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: isError
        ? Colors.red
        : isInformation
            ? Colors.black
            : Colors.orange,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
