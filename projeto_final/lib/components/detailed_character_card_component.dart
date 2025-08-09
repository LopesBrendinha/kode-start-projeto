import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/rickandmorty_controller.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/models/detailed_character.dart';

class DetailedCharacterCardComponent extends StatelessWidget {
  DetailedCharacterCardComponent({required this.character, super.key});
  final RickandmortyController controller = RickandmortyController();
  final DetailedCharacter character;

  void getEpisode() async {
  try {
    String url = character.episode as String; 
    Map<String, dynamic> episodeData = await controller.fetchEpisodeByUrl(url);
  } catch (e) {
    print(e); 
  }
}

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          Container(
            color: AppColors.primaryColorLight,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 160), 
                Text(
                  character.name.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    fontFamily: "Lato",
                  ),
                ),
                const SizedBox(height: 38),
                _buildBulletAndInfo(character.status, character.species),
                const SizedBox(height: 15),
                _buildInfoRow('Last known location: ', character.location.name),
                const SizedBox(height: 15),
                _buildEpisodeInfo(character.episode[0]),
                const SizedBox(height: 15),
                _buildInfoRow('Origin:', character.origin.name),
                const SizedBox(height: 15),
                _buildInfoRow('Gender:', character.gender),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                child: Image.network(
                  character.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 160,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletAndInfo(String status, String species) {
    Color bulletColor;

    bulletColor =
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
                border: Border.all(color: AppColors.white, width: 1),
              ),
              margin: const EdgeInsets.only(right: 8),
            ),
          Expanded(
            child: Text(
              "$status - $species",
              style: TextStyle(
                color: AppColors.white,
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

  Widget _buildInfoRow(String label, String value) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: AppColors.white,
              fontSize: 12.5,
              fontFamily: "Lato",
            ),
          ),
          SizedBox( height:  4,
          ),
          Text(
            '$value ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontSize: 12.5,
              fontFamily: "Lato",
            ),
          ),
      
        ],
    );
  }
  Widget _buildEpisodeInfo(String episodeUrl) {
    return FutureBuilder<Map<String, dynamic>>(
      future: controller.fetchEpisodeByUrl(episodeUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); 
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final episodeData = snapshot.data!;
          return _buildInfoRow('First seen in:', episodeData['name'] ?? 'Unknown');
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
