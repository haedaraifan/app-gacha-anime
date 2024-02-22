import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gacha/common/widgets/custom_text.dart';

class CustomDialog {
  static void showAlertDialog(BuildContext context, String imagePath, void Function() action) {
    print("path : $imagePath");
    showDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: CustomText.withPoppinsFont("Confirm delete?"),
        content: Image.file(
          File(imagePath)
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: CustomText.withPoppinsFont("No"),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              action();
            },
            child: CustomText.withPoppinsFont("Yes"),
          )
        ],
      )
    );
  }
}