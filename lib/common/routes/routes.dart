import 'package:gacha/pages/gallery/gallery_binding.dart';
import 'package:gacha/pages/gallery/gallery_page.dart';
import 'package:gacha/pages/home/home_binding.dart';
import 'package:gacha/pages/home/home_page.dart';
import 'package:get/get.dart';

class Routes {
  static const String home = "/home";
  static const String gallery = "/gallery";

  static List<GetPage> all = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.rightToLeftWithFade
    ),
    GetPage(
      name: gallery,
      page: () => const GalleryPage(),
      binding: GalleryBinding(),
      transition: Transition.leftToRightWithFade
    )
  ];
}