import 'package:flutter/material.dart';
import 'package:gacha/common/routes/routes.dart';
import 'package:get/get.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const MyBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storage),
          label: "gallery"
        )
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Get.back();
            break;
          case 1:
            Get.toNamed(Routes.gallery);
            break;
          default:
        }
      },
    );
  }
}