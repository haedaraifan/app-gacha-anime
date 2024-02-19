import 'package:flutter/material.dart';
import 'package:gacha/common/db/db_helper.dart';
import 'package:gacha/common/routes/routes.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'gacha',
      initialRoute: Routes.home,
      getPages: Routes.all,
      debugShowCheckedModeBanner: false,
    );
  }
}