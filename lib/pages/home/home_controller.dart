import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gacha/common/db/db_helper.dart';
import 'package:gacha/common/models/api/waifu_model.dart';
import 'package:gacha/common/models/sqflite/image_model.dart';
import 'package:gacha/common/routes/routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  Database db = DbHelper.getDb();
  
  RxBool isLoading = false.obs;
  RxBool isFavorite = false.obs;
  Rx<WaifuRes> model = WaifuRes().obs;
  RxString imageUrl = "".obs;
  RxString artistName = "".obs;

  @override
  void onInit() {
    super.onInit();
    imageUrl.value = "https://upload.wikimedia.org/wikipedia/commons/7/71/Black.png";
    get();
  }

  void get() async {
    isLoading.value = true;
    try {

      final response = await http.get(
        Uri.parse("https://api.waifu.im/search?included_tags=waifu")
      );

      if(response.statusCode == 200) {
        model.value = waifuResFromMap(response.body);

        print("artist : ${model.value.images![0].artist.name}");
        imageUrl.value = model.value.images![0].url;
        artistName.value = model.value.images![0].artist.name;
      }

    } catch(e) {
      print("error : $e");
    }
    isLoading.value = false;
    isFavorite.value = false;
  }

  void save() async {
    print("saving...");
    isLoading.value = true;
    if(isFavorite.value) return;

    try {

      ImageResponseModel target = model.value.images![0];
      final response = await http.get(Uri.parse(target.url));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final filePath = "${documentDirectory.path}/images";
      final fileName = "${documentDirectory.path}/images/${target.imageId}.png";

      await Directory(filePath).create(recursive: true);
      File file = File(fileName);

      if(!await file.exists()) {
        file.writeAsBytesSync(response.bodyBytes);
        ImageModel newImage = ImageModel(
          id: target.imageId,
          path: fileName
        );
        await db.insert("images", newImage.toMap());
      }

      print("path : $fileName");
      isFavorite.value = true;
      
    } catch(e) {
      print("error : $e");
    }
    
    isLoading.value = false;
  }

  String formatPath(String imagePath) {
    if(imagePath.startsWith("file://")) return imagePath.substring(7);
    return imagePath;
  }

  void onVerticalSwipe(SwipeDirection direction) {
    if(direction == SwipeDirection.up && !isLoading.value) get();
  }

  void onHorizontalSwipe(SwipeDirection direction) {
    if(direction == SwipeDirection.left && !isLoading.value) Get.toNamed(Routes.gallery);
  }
}