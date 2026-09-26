
import 'package:crud_getx_firebase/views/edit_user_view.dart';
import 'package:crud_getx_firebase/views/profile_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'controllers/auth_controller.dart';
import 'controllers/user_controller.dart';
import 'views/add_user_view.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';
import 'views/signup_view.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();

// Initialize Firebase
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

// Register controllers only once
Get.put(AuthController(), permanent: true);
Get.put(UserController(), permanent: true);

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
title: 'UserHub',

// Device Preview
useInheritedMediaQuery: true,
locale: DevicePreview.locale(context),
builder: DevicePreview.appBuilder,

// App Theme
theme: ThemeData(
useMaterial3: true,
fontFamily: 'Poppins',
colorScheme: ColorScheme.fromSeed(
seedColor: const Color(0xFF4F46E5),
),
),

// Initial Route
initialRoute: '/login',

// Routes
getPages: [
GetPage(
name: '/login',
page: () => const LoginView(),
),

GetPage(
name: '/signup',
page: () => const SignupView(),
),

GetPage(
name: '/home',
page: () => const HomeView(),
),

GetPage(
name: '/add-user',
page: () => const AddUserView(),
),

GetPage(
name: '/profile',
page: () => ProfileView(),
),

GetPage(
name: '/edit-user',
page: () => const EditUserView(),
),
],
);
}
}

