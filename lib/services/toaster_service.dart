// Package imports:
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// Project imports:

class ToasterService {
  static const authError = 'Authorisation Error!!';
  static const error = 'Incorrect Email or Password';
  static const emptyFields = 'Please fill out all Fields';
  static const newandconfirmpassword =
      'New password and confirm password do not match';
  static const incorrectoldpassword = 'Old password is incorrect';
  static const passwordchanged = 'Password Changed Successfully ';
  static const networkissue = 'Oops, Something went wrong Try Again.';
  static const errorMsg = 'Operation Failed';
  static const successMsg = 'Operation Successfull';
  static const dateError = 'TO DATE must be greater than FROM DATE';
  static const invalidCancellation =
      'You can only cancel PENDING or ACCEPTED booking';
  static const invalidRemove = 'You can only delete PENDING booking';
  static const validationError =
      'Mandatory parameters are marked with asterik (*)';
}

snackBarNotification(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppTheme.main,
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      behavior: SnackBarBehavior.floating,
      // margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

snackBarErrorMessage(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppTheme.red,
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      behavior: SnackBarBehavior.floating,
      // margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

snackBarErr(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      // margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

snackBarError(context, GlobalKey<FormState> globalFormKey) {
  if (globalFormKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.red,
        content: const Text(
          ToasterService.validationError,
          style: TextStyle(fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
        // margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

snackBarValidation() {
  SnackBar(
    backgroundColor: AppTheme.red,
    content: const Text(
      ToasterService.validationError,
      style: TextStyle(fontSize: 16),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

toastError(error) {
  // Fluttertoast.showToast(
  //   msg: error,
  //   timeInSecForIosWeb: 2,
  //   webShowClose: true,
  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.CENTER,
  //   backgroundColor: AppTheme.red,
  //   textColor: AppTheme.white,
  //   fontSize: 16.0,
  // );
}

toastAlert(msg) {
  // Fluttertoast.showToast(
  //   msg: msg,
  //   timeInSecForIosWeb: 2,
  //   webShowClose: true,
  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.CENTER,
  //   backgroundColor: AppTheme.black,
  //   textColor: AppTheme.white,
  //   fontSize: 16.0,
  // );
}
