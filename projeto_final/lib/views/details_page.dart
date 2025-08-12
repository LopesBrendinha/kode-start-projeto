import 'package:flutter/material.dart';
import 'package:projeto_final/components/appbar_component.dart';
import 'package:projeto_final/components/detailed_character_card_component.dart';
import 'package:projeto_final/controllers/character_controller.dart';
import 'package:projeto_final/controllers/rickandmorty_controller.dart';
import 'package:projeto_final/models/detailed_character.dart';
import 'package:projeto_final/theme/app_colors.dart';

class DetailsPage extends StatefulWidget {
  final int characterId;

  const DetailsPage({required this.characterId, Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<DetailedCharacter> detailedCharacter;
  final RickandmortyController controller = RickandmortyController();
  final CharacterController characterController = CharacterController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    detailedCharacter = controller.fetchCharacterById(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundColor : AppColors.lightBackgroundColor;
    final textColor = isDarkMode ? AppColors.white : AppColors.lightBlack;

    return Scaffold(
      appBar: AppBarComponent(
        isHomePage: false,
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onTap2: () {
          null;
        },
        isProfilePage: false,
      ),
      backgroundColor: backgroundColor,
      body: FutureBuilder<DetailedCharacter>(
        future: detailedCharacter,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final character = snapshot.data!;
            return FutureBuilder<bool>(
              future: characterController.characterExists(character.id),
              builder: (context, favSnapshot) {
                if (favSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: isDarkMode ? AppColors.white : AppColors.primaryColorDark,
                    ),
                  );
                } else if (favSnapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao verificar favorito',
                      style: TextStyle(color: textColor),
                    ),
                  );
                } else {
                  final isFavorite = favSnapshot.data ?? false;
                  return ListView(
                    children: [
                      DetailedCharacterCardComponent(
                        character: character,
                        isFavorite: isFavorite,
                        onToggleFavorite: () async {
                          if (isFavorite) {
                            await characterController.deleteCharacter(character.id);
                          } else {
                            await characterController.addCharacter(character);
                          }
                          setState(() {}); 
                        },
                      ),
                    ],
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro.",
                style: TextStyle(color: textColor),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: isDarkMode ? AppColors.white : AppColors.primaryColorDark,
              ),
            );
          }
        },
      ),
    );
  }
}