import 'dart:async';

import 'package:day20_mvc_getx/routes/app_routes.dart' show AppRoutes;
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

    scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    animationController.forward();

    Timer(
      const Duration(seconds: 2),
          () {
        Get.offNamed(AppRoutes.home);
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1F3A),
      body: Center(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF1769E0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1769E0).withOpacity(0.30),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.code_rounded,
                    color: Colors.white,
                    size: 52,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'My Development Hub',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'My projects • My progress • My journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFB8D8FF),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  'Flutter  •  MVC  •  GetX',
                  style: TextStyle(
                    color: Color(0xFF7DB7FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}