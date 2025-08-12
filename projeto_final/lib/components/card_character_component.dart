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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      color: AppColors.getCardColor(isDarkMode), 
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: 160,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 160,
                  color: AppColors.getCardColor(isDarkMode),
                  child: Icon(
                    Icons.error_outline,
                    color: AppColors.red,
                    size: 40,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                characterName.toUpperCase(),
                style: TextStyle(
                  color: AppColors.getTextColor(isDarkMode), // Cor fixa do texto
                  fontWeight: FontWeight.w900,
                  fontSize: 14.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}