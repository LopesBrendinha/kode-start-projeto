import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:projeto_final/controllers/rickandmorty_controller.dart';
import 'package:projeto_final/models/detailed_character.dart';
import 'package:projeto_final/theme/app_colors.dart';

class DetailedCharacterCardComponent extends StatelessWidget {
  final DetailedCharacter character;
  final bool isFavorite;
  final Future<void> Function() onToggleFavorite;

  DetailedCharacterCardComponent({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final RickandmortyController controller = RickandmortyController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          Container(
            color: isDarkMode 
                ? AppColors.primaryColorLight
                : AppColors.primaryColorDark,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 160),
                Text(
                  character.name.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.getTextColor(isDarkMode),
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    fontFamily: "Lato",
                  ),
                ),
                const SizedBox(height: 38),
                _buildBulletAndInfo(
                  character.status,
                  character.species,
                  isDarkMode,
                ),
                const SizedBox(height: 15),
                _buildInfoRow(
                  translate("Last known location: "),
                  character.location.name,
                  isDarkMode,
                ),
                const SizedBox(height: 15),
                _buildEpisodeInfo(character.episode[0], isDarkMode),
                const SizedBox(height: 15),
                _buildInfoRow(translate('Origin: '), character.origin.name, isDarkMode),
                const SizedBox(height: 15),
                _buildInfoRow(translate('Gender: '), character.gender, isDarkMode),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
              child: Image.network(
                character.image,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 160,
              ),
            ),
          ),

          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isDarkMode ? AppColors.white : AppColors.primaryColorDark,
              ),
              onPressed: onToggleFavorite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletAndInfo(String status, String species, bool isDarkMode) {
    Color bulletColor =
        status == "Alive"
            ? AppColors.green
            : status == "Dead"
                ? AppColors.red
                : AppColors.gray;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (bulletColor != Colors.transparent)
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: bulletColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode ? AppColors.white : AppColors.primaryColorDark, 
                width: 1,
              ),
            ),
            margin: const EdgeInsets.only(right: 8),
          ),
        Expanded(
          child: Text(
            "$status - $species",
            style: TextStyle(
              color: AppColors.getTextColor(isDarkMode),
              fontWeight: FontWeight.w500,
              fontFamily: "Lato",
              fontSize: 12.5,
              letterSpacing: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: AppColors.getTextColor(isDarkMode),
            fontSize: 12.5,
            fontFamily: "Lato",
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.getTextColor(isDarkMode),
            fontSize: 12.5,
            fontFamily: "Lato",
          ),
        ),
      ],
    );
  }

  Widget _buildEpisodeInfo(String episodeUrl, bool isDarkMode) {
    return FutureBuilder<Map<String, dynamic>>(
      future: controller.fetchEpisodeByUrl(episodeUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: isDarkMode ? AppColors.white : AppColors.primaryColorDark,
          );
        } else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
            style: TextStyle(color: AppColors.getTextColor(isDarkMode)),
          );
        } else if (snapshot.hasData) {
          final episodeData = snapshot.data!;
          return _buildInfoRow(
            translate('First seen in: '),
            episodeData['name'] ?? translate('Unknown'),
            isDarkMode,
          );
        } else {
          return Text(
            translate('No data available'),
            style: TextStyle(color: AppColors.getTextColor(isDarkMode)),
          );
        }
      },
    );
  }
}