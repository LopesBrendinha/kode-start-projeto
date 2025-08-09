import 'package:flutter/material.dart';
import 'package:projeto_final/components/appbar_component.dart';
import 'package:projeto_final/components/card_character_component.dart';
import 'package:projeto_final/components/navigation_drawer_component.dart';
import 'package:projeto_final/controllers/rickandmorty_controller.dart';
import 'package:projeto_final/models/detailed_character.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/views/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RickandmortyController rickandmortyController =
      RickandmortyController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  List<DetailedCharacter> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _isSearching = false;
  bool _hasError = false;
  String _errorMessage = '';
  String _search = '';
  String? _statusFilter;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadCharacters();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _search.isEmpty) {
      _loadCharacters();
    }
  }

  void _loadCharacters() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final newCharacters =
          _search.isEmpty
              ? await rickandmortyController.fetchCharacters(_currentPage)
              : await rickandmortyController.fetchCharactersByName(_search);

      setState(() {
        if (_search.isEmpty) {
          _characters.addAll(newCharacters);
          _currentPage++;
        } else {
          _characters = newCharacters;
        }
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
        _isSearching = false;
      });
    }
  }

  void _refresh() {
    setState(() {
      _currentPage = 1;
      _characters.clear();
    });
    _loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarComponent(
        isHomePage: true,
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      backgroundColor: AppColors.backgroundColor,
      drawer: NavigationDrawerComponent(),
      body: Column(
        children: [
          Container(
            color: AppColors.appBarColor,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Pesquise aqui",
                      labelStyle: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Lato",
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColorDark,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColorLight,
                        ),
                      ),
                      suffixIcon: Icon(Icons.search, color: AppColors.white),
                    ),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontFamily: "Lato",
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _search = value;
                        _currentPage = 1;
                        _characters.clear();
                        _isSearching = true;
                      });
                      _loadCharacters();
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    dropdownColor: AppColors.appBarColor,
                    decoration: InputDecoration(
                      labelText: "Filtro",
                      labelStyle: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Lato",
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColorDark,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColorLight,
                        ),
                      ),
                    ),
                    style: TextStyle(color: AppColors.white),
                    iconEnabledColor: AppColors.white,
                    items: [
                      DropdownMenuItem(value: "Alive", child: Text("Alive")),
                      DropdownMenuItem(value: "Dead", child: Text("Dead")),
                      DropdownMenuItem(
                        value: "Unknown",
                        child: Text("Unknown"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _statusFilter = value;
                        _currentPage = 1;
                        _characters.clear();
                        _isSearching = true;
                      });
                      _loadCharacters();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                _hasError
                    ? Center(
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: AppColors.white),
                      ),
                    )
                    : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      itemCount: _characters.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < _characters.length) {
                          final character = _characters[index];
                          return CardCharacterComponent(
                            characterName: character.name,
                            characterImg: character.image,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DetailsPage(
                                        characterId: character.id,
                                      ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
