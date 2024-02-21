import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gacha/pages/home/home_controller.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {  
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.pink,
          backgroundColor: Colors.white,
          onPressed: () => controller.save(context),
          child: Obx(
            () => controller.isFavorite.value
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border_outlined)
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children:[
              SimpleGestureDetector(
                onVerticalSwipe: controller.onVerticalSwipe,
                onHorizontalSwipe: controller.onHorizontalSwipe,
                swipeConfig: const SimpleSwipeConfig(
                  horizontalThreshold: 60,
                  swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct
                ),
                child: Center(
                  child: Obx(
                    () => CachedNetworkImage(
                      imageUrl: controller.imageUrl.value,
                      placeholder: (context, url) => const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                )
              ),
              Obx(
                () => controller.isLoading.value
                ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
                : const SizedBox()
              )
            ]
          ),
        )
      )
    );
  }
}