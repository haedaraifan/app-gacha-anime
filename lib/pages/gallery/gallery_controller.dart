import 'dart:io';
import 'package:gacha/common/db/db_helper.dart';
import 'package:gacha/common/models/sqflite/image_model.dart';
import 'package:get/get.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:sqflite/sqflite.dart';

class GalleryController extends GetxController {
  Database db = DbHelper.getDb();

  RxBool isLoading = false.obs;
  RxBool isDeleteModeActive = false.obs;
  late List<ImageModel> images;

  @override
  void onInit() {
    super.onInit();
    getImages();
  }

  void getImages() async {
    print("get images");
    isLoading.value = true;

    try {
      List<Map<String, dynamic>> mapImages = await db.query("images");
      images = mapImages.map((e) => ImageModel.fromMap(map: e)).toList();
    } catch(e) {
      print("error : $e");
    }
    
    isLoading.value = false;
  }

  void deleteModeToggle() {
    isDeleteModeActive.value = !isDeleteModeActive.value;

    print("isDeleteModeActive ${isDeleteModeActive.value}");
  }

  void  delete(ImageModel target) async {
    print("deletng...");
    isLoading.value = true;

    try {

      File file = File(target.path);
      print("target.path : ${target.path}");

      await db.delete("images", where: "id = ?", whereArgs: [target.id]);
      if(await file.exists()) {
        print("file found");
        await file.delete();
        print("file deleted");
      }
      getImages();

    } catch(e) {
      print("error $e");
    }
    
    isDeleteModeActive.value = false;
    isLoading.value = false;
  }

  void onHorizontalSwipe(SwipeDirection direction) {
    if(direction == SwipeDirection.right) Get.back();
  }
}