import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gacha/common/db/db_helper.dart';
import 'package:gacha/common/models/api/waifu_model.dart';
import 'package:gacha/common/models/sqflite/image_model.dart';
import 'package:gacha/common/routes/routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  Database db = DbHelper.getDb();
  
  RxString imageUrl = "".obs;
  RxBool isLoading = false.obs;
  Rx<WaifuRes> model = WaifuRes().obs;

  @override
  void onInit() {
    super.onInit();
    imageUrl.value = "https://static.hillarys.co.uk/asset/media/9635/pure-white.jpg?mode=crop&mcb=5f884e47a7424cfe86340315ccaafed0";
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
        String url = model.value.images![0].url;

        print(url);
        imageUrl.value = url;
      }

    } catch(e) {
      print("error : $e");
    }
    isLoading.value = false;
  }

  void save(BuildContext context) async {
    print("save!");
    isLoading.value = true;
    ImageResponseModel target = model.value.images![0];
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    var response = await Dio().get(
      imageUrl.value,
      options: Options(
        responseType: ResponseType.bytes
      )
    );
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
      name: target.imageId.toString()
    );

    print("result");
    print(result["filePath"]);

    if(result != null) {
      ImageModel newImage = ImageModel(
        id: target.imageId,
        path: formatPath(result["filePath"])
      );
      print("save to db!");
      await db.insert("images", newImage.toMap());
      isLoading.value = false;
      scaffoldMessenger.showSnackBar(const SnackBar(content: Text("image saved!")));
    }
  }

  String formatPath(String imagePath) {
    if(imagePath.startsWith("file://")) return imagePath.substring(7);
    return imagePath;
  }

  void onVerticalSwipe(SwipeDirection direction) {
    if(direction == SwipeDirection.up) get();
  }

  void onHorizontalSwipe(SwipeDirection direction) {
    if(direction == SwipeDirection.left) Get.toNamed(Routes.gallery);
  }
}