import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gacha/common/db/db_helper.dart';
import 'package:gacha/common/models/api/waifu_model.dart';
import 'package:gacha/common/models/sqflite/image_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  Database db = DbHelper.getDb();
  
  RxString imageUrl = "".obs;
  RxBool isLoading = false.obs;
  Rx<WaifuRes> model = WaifuRes().obs;

  @override
  void onInit() {
    imageUrl.value = "https://animeargentina.net/wp-content/uploads/2022/05/hotarun-non-non-biyori-1024x576.jpg";
    super.onInit();
  }

  void get() async {
    try {

      isLoading.value = true;
      final response = await http.get(
        Uri.parse("https://api.waifu.im/search?included_tags=waifu")
      );

      if(response.statusCode == 200) {
        model.value = waifuResFromMap(response.body);
        String url = model.value.images![0].url;

        print(url);
        imageUrl.value = url;
      }
      isLoading.value = false;

    } catch(e) {
      print("error : $e");
    }
  }

  void save(BuildContext context) async {
    print("save!");
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
      scaffoldMessenger.showSnackBar(const SnackBar(content: Text("image saved!")));
    }
  }

  String formatPath(String imagePath) {
    if(imagePath.startsWith("file://")) return imagePath.substring(7);
    return imagePath;
  }
}