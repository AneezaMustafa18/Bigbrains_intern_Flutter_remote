
import 'package:day20_mvc_getx/controllers/project_controller.dart';
import 'package:day20_mvc_getx/controllers/user_controller.dart';
import 'package:day20_mvc_getx/routes/app_routes.dart';
import 'package:day20_mvc_getx/view/onboarding/splash_view.dart' show SplashView;
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
Get.put(UserController());
Get.put(ProjectController());

runApp(
DevicePreview(
enabled: !kReleaseMode,
builder: (context) => const MyApp(),
),
);
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return GetMaterialApp(
debugShowCheckedModeBanner: false,
title: 'My Development Hub',

// Start directly with SplashView
home: const SplashView(),

getPages: AppRoutes.routes,
);
}
}

