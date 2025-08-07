import 'package:flutter/material.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/theme/app_images.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarComponent({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight * 2.2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      leading: Align(
        alignment: Alignment.topCenter,
        child: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(right: 13.98, top: 12),
          child: GestureDetector(
            onTap: () {},
            child: Image.asset(
              AppImages.icon1,
              height: 31.46,
              width: 31.46,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Image.asset(AppImages.logo),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                "RICK AND MORTY API",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.5,
                  letterSpacing: 1.16, 
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}