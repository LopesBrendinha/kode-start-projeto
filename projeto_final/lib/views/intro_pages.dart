import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/theme/app_images.dart';

class IntroPages extends StatefulWidget {
  const IntroPages({super.key});

  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: AppColors.appBarColor,
      key: _introKey,
      pages: [
        PageViewModel(
          title: translate('intro.page1.title'),
          body: translate('intro.page1.body'),
          image: Image.asset(
            AppImages.intro1,
            height: 250,
            fit: BoxFit.contain,
          ),
          decoration: _pageDecoration(),
        ),
        PageViewModel(
          title: translate('intro.page2.title'),
          body: translate('intro.page2.body'),
          image: Image.asset(
            AppImages.intro2,
            height: 250,
            fit: BoxFit.contain,
          ),
          decoration: _pageDecoration(),
        ),
        PageViewModel(
          title: translate('intro.page3.title'),
          body: translate('intro.page3.body'),
          image: Image.asset(
            AppImages.intro3,
            height: 250,
            fit: BoxFit.contain,
          ),
          decoration: _pageDecoration(),
        ),
        PageViewModel(
          title: translate('intro.page4.title'),
          body: translate('intro.page4.body'),
          image: Image.asset(
            AppImages.intro4,
            height: 250,
            fit: BoxFit.contain,
          ),
          decoration: _pageDecoration(),
        ),
      ],
      showSkipButton: true,
      skip: Text(translate('intro.skip'), style: const TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: Text(
        translate('intro.done'),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      onDone: () => Navigator.pushReplacementNamed(context, "/loginPage"),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: AppColors.gray,
        activeColor: AppColors.primaryColorLight,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  PageDecoration _pageDecoration() {
    return PageDecoration(
      titleTextStyle: TextStyle(
        color: AppColors.primaryColorLight,
        fontFamily: "Lato",
        fontWeight: FontWeight.w900,
        fontSize: 25,
      ),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        fontFamily: "Lato",
        color: AppColors.white,
      ),
    );
  }
}