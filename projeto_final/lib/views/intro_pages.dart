import 'package:flutter/material.dart';
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
  String _status = 'Waiting...';

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: AppColors.appBarColor,
      key: _introKey,
      pages: [
        PageViewModel(
          title: "Welcome to the Rick and Morty Universe",
          body:
              "Explore every corner of the multiverse and discover amazing info about your favorite characters.",
          image: Image.asset(
            AppImages.intro1,
            height: 250,
            fit: BoxFit.contain,
          ),
          decoration: PageDecoration(
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
          ),
        ),

        PageViewModel(
          title: "Discover Characters and Episodes",
          body:
              "Search, filter, and learn fun facts about each character and episode from the show.",
          image: Image.asset(
            AppImages.intro2,
            height: 250,
            fit: BoxFit.contain,
          ),
          decoration: PageDecoration(
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
          ),
        ),

        PageViewModel(
          title: "Save Your Favorites",
          body:
              "Keep your favorite characters and episodes handy to revisit anytime.",
          image: Image.asset(
            AppImages.intro3,
            height: 250,
            fit: BoxFit.contain,
          ),
          decoration: PageDecoration(
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
          ),
        ),

        PageViewModel(
          title: "Get Ready for Epic Adventures",
          body:
              "Travel across dimensions and explore everything the official Rick and Morty API has to offer.",
          image: Image.asset(
            AppImages.intro4,
            height: 250,
            fit: BoxFit.contain,
          ),
          decoration: PageDecoration(
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
          ),
        ),
      ],
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        "Get Started",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onDone:
          () {
            Navigator.pushReplacementNamed(context, "/loginPage");
          },
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
}
