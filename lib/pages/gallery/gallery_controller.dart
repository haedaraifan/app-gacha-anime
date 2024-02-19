import 'package:gacha/common/db/db_helper.dart';
import 'package:gacha/common/models/sqflite/image_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class GalleryController extends GetxController {
  Database db = DbHelper.getDb();

  RxBool isLoading = false.obs;
  late List<ImageModel> images;

  @override
  void onInit() {
    super.onInit();
    getImages();
  }

  void getImages() async {
    isLoading.value = true;
    List<Map<String, dynamic>> mapImages = await db.query("images");
    images = mapImages.map((e) => ImageModel.fromMap(map: e)).toList();
    isLoading.value = false;
  }
}