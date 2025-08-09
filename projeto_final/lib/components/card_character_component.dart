import 'package:flutter/material.dart';
import 'package:projeto_final/theme/app_colors.dart';

class CardCharacterComponent extends StatelessWidget {
  final void Function() onTap;
  final String characterName;
  final String characterImg;

  const CardCharacterComponent({
    super.key,
    required this.onTap,
    required this.characterName,
    required this.characterImg,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              characterImg,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 160,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                characterName.toUpperCase(),
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
