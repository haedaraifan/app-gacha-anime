import 'package:flutter/material.dart';
import 'package:gacha/common/widgets/bottom_navbar.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gacha/pages/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {  
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => controller.save(context),
          child: const Icon(Icons.save),
        ),
        body: Center(
          child: Obx(
            () => InkWell(
              onTap: controller.get,
              child: CachedNetworkImage(
                imageUrl: controller.imageUrl.value,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            )
          )
        ),
        bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 0),
      )
    );
  }
}