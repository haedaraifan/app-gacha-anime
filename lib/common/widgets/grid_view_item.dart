import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gacha/common/models/sqflite/image_model.dart';
import 'package:gacha/common/widgets/custom_dialog.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class GridViewItem {
  static Widget build(ImageModel item) {
    return InstaImageViewer(child: Image.file(File(item.path)));
  }

  static Widget buildDeleteMode(BuildContext context, ImageModel item, void Function() action) {
    return Stack(
      children: [
        Image.file(File(item.path)),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            onPressed: () => CustomDialog.showAlertDialog(context, item.path, action),
            icon: const Icon(
              Icons.delete,
              color: Colors.pink,
            )
          )
        ),
      ],
    );
  }
}