import 'package:flutter/material.dart';
import 'package:projeto_final/components/appbar_component.dart';
import 'package:projeto_final/components/detailed_character_card_component.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    detailedCharacter = controller.fetchCharacterById(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        isHomePage: false,
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<DetailedCharacter>(
        future: detailedCharacter,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                DetailedCharacterCardComponent(character: snapshot.data!),
              ],
            );
          } else if (snapshot.hasError) {
            print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
            print(snapshot.error);
            return Center(
              child: Text(
                "Ocorreu um erro.",
                style: TextStyle(color: AppColors.white),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
