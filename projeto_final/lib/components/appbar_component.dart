import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:projeto_final/theme/app_images.dart';
import 'package:projeto_final/theme/app_colors.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool isHomePage;
  final bool isProfilePage;
  final VoidCallback onTap;
  final VoidCallback onTap2;

  const AppBarComponent({
    Key? key,
    required this.isHomePage,
    required this.onTap,
    required this.onTap2,
    required this.isProfilePage,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight * 2.2),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: AppColors.getAppBarColor(isDarkMode),
      leading: Align(
        alignment: Alignment.topCenter,
        child:
            isHomePage
                ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: onTap,
                  color: AppColors.getTextColor(isDarkMode),
                )
                : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: AppColors.getTextColor(isDarkMode),
                ),
      ),
      actions: [
        if (!isProfilePage)
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(right: 13.98, top: 12),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/profilePage"),
              child:
                  isDarkMode
                      ? Image.asset(
                        AppImages.icon1,
                        height: 31.46,
                        width: 31.46,
                      )
                      : Image.asset(
                        AppImages.icon1,
                        height: 31.46,
                        width: 31.46,
                        color: AppColors.getTextColor(isDarkMode),
                      ),
            ),
          ),
      ],
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: isHomePage ? onTap2 : () => Navigator.pop(context),
              child: Image.asset(AppImages.logo, width: 115, height: 76.99),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                translate("RICK AND MORTY API"),
                style: TextStyle(
                  color: AppColors.getTextColor(isDarkMode),
                  fontSize: 14.5,
                  letterSpacing: 1.20,
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
