import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gacha/common/models/sqflite/image_model.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class ArrayToWidget {
  static List<Widget> gridItems(List<ImageModel> items) {
    return items.map((item) => InstaImageViewer(child: Image.file(File(item.path)))).toList();
  }
}