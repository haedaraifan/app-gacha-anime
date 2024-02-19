import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gacha/common/widgets/array_to_widget.dart';
import 'package:get/get.dart';
import 'package:gacha/common/widgets/bottom_navbar.dart';
import 'package:gacha/pages/gallery/gallery_controller.dart';

class GalleryPage extends GetView<GalleryController> {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
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
        bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
      )
    );
  }
}