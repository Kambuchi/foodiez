import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Dialogs {
  static Future<void> alert(
    BuildContext context, {
    String? title,
    String? description,
    String okText = 'OK',
    bool dissmisable = true,
  }) {
    return showDialog(
      barrierDismissible: dissmisable,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => dissmisable,
        child: AlertDialog(
          title: title != null ? Text(title) : null,
          content: description != null ? Text(description) : null,
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text(okText))
          ],
        ),
      ),
    );
  }

  static Future<bool?> confirm(
    BuildContext context, {
    String? title,
    String? description,
    String okText = 'OK',
    bool dissmisable = true,
  }) async {
    final result = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (_) => WillPopScope(
        child: CupertinoActionSheet(
          title: title != null ? Text(title) : null,
          message: description != null ? Text(description) : null,
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(_, true);
              },
              child: Text(okText),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(_, false);
              },
              child: Text('Cancel'),
              isDestructiveAction: true,
            ),
          ],
        ),
        onWillPop: () async => false,
      ),
    );

    return result ?? false;
  }
}

abstract class ProgressDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              color: Colors.white30,
              child: CircularProgressIndicator(),
            ));
  }
}
