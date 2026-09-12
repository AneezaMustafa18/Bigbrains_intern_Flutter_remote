import 'package:bigbrains_day3/screens/day10/day10.dart';
import 'package:bigbrains_day3/screens/day3/Day3.dart';
import 'package:bigbrains_day3/screens/day6/chat_screen.dart';
import 'package:bigbrains_day3/screens/day6/chats_screen.dart';
import 'package:bigbrains_day3/screens/day7/Day7.dart';
import 'package:bigbrains_day3/screens/day7/todo_tile.dart';
import 'package:bigbrains_day3/screens/day8/day8.dart';
import 'package:bigbrains_day3/screens/day9/day9.dart' show Day9;
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
      title: 'TodoApp',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent.shade200,
      ),
      home:  Day10(),
    );
  }
}

