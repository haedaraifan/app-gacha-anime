import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gacha/common/widgets/grid_view_item.dart';
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
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.pink,
          backgroundColor: Colors.white,
          onPressed: controller.deleteModeToggle,
          child: Obx(
            () => controller.isDeleteModeActive.value
            ? const Icon(Icons.cancel)
            : const Icon(Icons.delete)
          ),
        ),
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
                child: CircularProgressIndicator(
                  color: Colors.white,
                )
              )
              : MasonryGridView.builder(
                itemCount: controller.images.length,
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(2),
                  child: Obx(
                    () => controller.isDeleteModeActive.value
                    ? GridViewItem.buildDeleteMode(
                      context,
                      controller.images[index],
                      () => controller.delete(controller.images[index])
                    )
                    : GridViewItem.build(controller.images[index])
                  )
                )
              )
            ),
          ),
        ),
      )
    );
  }
}