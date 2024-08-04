// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/themes/app_theme.dart';

enum DialogAction { yes, abort }

class ConfirmationDialog {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title),
          content: Text(
            body,
            style: const TextStyle(color: AppTheme.defaultTextColor),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text(
                'No',
                // style: TextStyle(color: AppTheme.defaultTextColor,),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'Yes',
                // style: TextStyle(color: AppTheme.red),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
