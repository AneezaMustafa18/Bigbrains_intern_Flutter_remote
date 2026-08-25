import 'package:bigbrains_day3/screens/day3/Day3.dart';
import 'package:bigbrains_day3/screens/day6/chat_screen.dart';
import 'package:bigbrains_day3/screens/day6/chats_screen.dart';
import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';



import 'package:flutter/material.dart';
import 'package:bigbrains_day3/screens/day6/chats_screen.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const ChatsScreen(),
    );
  }
}

