import 'package:flutter/material.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/models/detailed_character.dart';

class DetailedCharacterCardComponent extends StatelessWidget {
  const DetailedCharacterCardComponent({required this.character, super.key});

  final DetailedCharacter character;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            character.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Espécie:', character.species),
                _buildInfoRow('Gênero:', character.gender),
                _buildInfoRow('Status:', character.status),
                _buildInfoRow('Origem:', character.origin.name),
                _buildInfoRow('Última localização:', character.location.name),
                _buildInfoRow('Primeira aparição:', character.episode.isNotEmpty ? character.episode[0] : 'Desconhecida'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
