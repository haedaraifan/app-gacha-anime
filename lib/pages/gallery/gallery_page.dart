import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gacha/common/widgets/array_to_widget.dart';
import 'package:get/get.dart';
import 'package:gacha/pages/gallery/gallery_controller.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class GalleryPage extends GetView<GalleryController> {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SimpleGestureDetector(
            onHorizontalSwipe: controller.onHorizontalSwipe,
            swipeConfig: const SimpleSwipeConfig(
              horizontalThreshold: 40,
              swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct
            ),
            child: Obx(
              () => controller.isLoading.value
              ? const Center(
                child: CircularProgressIndicator()
              )
              : SingleChildScrollView(
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: ArrayToWidget.gridItems(controller.images)
                ),
              )
            ),
          ),
        ),
      )
    );
  }
}