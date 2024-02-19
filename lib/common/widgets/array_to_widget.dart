import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gacha/common/models/sqflite/image_model.dart';

class ArrayToWidget {
  static List<Widget> gridItems(List<ImageModel> items) {
    return items.map((item) => Image.file(File(item.path))).toList();
  }
}