import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/theme/app_images.dart';
import 'package:projeto_final/views/intro_pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin { 
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), 
    )..repeat();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroPages()), 
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logoSplash),
            const SizedBox(height: 20),
            Text( 
              translate('splash.loading_message'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontFamily: "Lato",
                fontWeight: FontWeight.w900, 
              ),
            ),
            const SizedBox(height: 20), 
            RotationTransition(
              turns: _controller,
              child: Image.asset(
                AppImages.picles, 
                width: 80,
                height: 80,
              ),
            ), 
          ],
        ),
      ),
    );
  }
}