import 'package:bigbrains_day3/Day3.dart';
import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';

 void main(){
   runApp(
     DevicePreview(
       enabled: !kReleaseMode,
       builder: (context) => MyApp(), // Wrap your app
     ),
   );
 }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Day3(),
    );

  }
}

