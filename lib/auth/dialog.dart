// ignore_for_file: deprecated_member_use, duplicate_ignore, prefer_const_constructors
import 'package:beautips/theme.dart';
import 'package:flutter/material.dart';

import '../pages/role/kasir/kasir_profile.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Text(
                'Batal',
                style: TextStyle(color: appBlack, fontSize: 15),
              ),
            ),
            FlatButton(
              onPressed: () {
                logout(context);
              },
              child: Text(
                'Ya',
                style: TextStyle(
                  color: apphijau,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            )
          ],
        );
      },
    );

    return (action != null) ? action : DialogsAction.cancel;
  }
}
