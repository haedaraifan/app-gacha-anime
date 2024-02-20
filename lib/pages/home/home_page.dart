import 'package:flutter/material.dart';
import 'package:gacha/common/widgets/bottom_navbar.dart';
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
          child: const Icon(Icons.favorite),
        ),
        body: SimpleGestureDetector(
          onVerticalSwipe: controller.onVerticalSwipe,
          onHorizontalSwipe: controller.onHorizontalSwipe,
          swipeConfig: const SimpleSwipeConfig(
            horizontalThreshold: 40,
            swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct
          ),
          child: Center(
            child: Obx(
              () => CachedNetworkImage(
                imageUrl: controller.imageUrl.value,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          )
        )
      )
    );
  }
}