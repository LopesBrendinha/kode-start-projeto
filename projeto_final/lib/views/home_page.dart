import 'package:flutter/material.dart';
import 'package:projeto_final/components/appbar_component.dart';
import 'package:projeto_final/components/card_character_component.dart';
import 'package:projeto_final/components/navigation_drawer_component.dart';
import 'package:projeto_final/controllers/rickandmorty_controller.dart';
import 'package:projeto_final/models/detailed_character.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/theme/app_images.dart';
import 'package:projeto_final/views/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RickandmortyController rickandmortyController = RickandmortyController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<DetailedCharacter> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasError = false;
  String _search = '';
  String? _statusFilter;
  String? _speciesFilter;
  String? _typeFilter;
  String? _genderFilter;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadCharacters();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      _loadCharacters();
    }
  }

  Future<void> _loadCharacters() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      List<DetailedCharacter> newCharacters;

      if (_search.isNotEmpty ||
          _speciesFilter != null ||
          _statusFilter != null ||
          _genderFilter != null ||
          _typeFilter != null) {
        newCharacters = await rickandmortyController.fetchCharactersByFilter(
          name: _search,
          species: _speciesFilter,
          status: _statusFilter,
          type: _typeFilter,
          gender: _genderFilter,
          page: _currentPage,
        );
      } else {
        newCharacters = await rickandmortyController.fetchCharacters(_currentPage);
      }

      setState(() {
        if (_currentPage == 1) {
          _characters = newCharacters;
        } else {
          _characters.addAll(newCharacters);
        }
        _currentPage++;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
      _characters.clear();
    });
    _loadCharacters();
  }

  void _refresh() {
    setState(() {
      _currentPage = 1;
      _characters.clear();
      _search = "";
      _searchController.clear();
      _statusFilter = null;
      _speciesFilter = null;
      _typeFilter = null;
      _genderFilter = null;
    });
    _loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundColor : AppColors.lightBackgroundColor;
    final appBarColor = isDarkMode ? AppColors.appBarColor : AppColors.white;
    final textColor = isDarkMode ? AppColors.white : AppColors.black;
    final primaryColor = isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColorLight;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarComponent(
        isHomePage: true,
        onTap: () => _scaffoldKey.currentState?.openDrawer(),
        onTap2: _refresh,
        isProfilePage: false,
      ),
      backgroundColor: backgroundColor,
      drawer: const NavigationDrawerComponent(),
      body: Column(
        children: [
          Container(
            color: appBarColor,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: "Search",
                      labelStyle: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Lato",
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: textColor),
                        onPressed: () {
                          setState(() {
                            _search = _searchController.text;
                            _currentPage = 1;
                            _characters.clear();
                          });
                          _loadCharacters();
                        },
                      ),
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontFamily: "Lato",
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _search = value;
                        _currentPage = 1;
                        _characters.clear();
                      });
                      _loadCharacters();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.filter_alt, color: textColor),
                  onPressed: _showFilterDialog,
                ),
              ],
            ),
          ),
          Expanded(
            child: _hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.erro404,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'We can\'t seem to find in this dimension',
                          style: TextStyle(color: textColor),
                        ),
                      ],
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
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                characterId: character.id,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(color: primaryColor),
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

  void _showFilterDialog() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final dialogColor = isDarkMode ? AppColors.appBarColor : AppColors.white;
    final textColor = isDarkMode ? AppColors.white : AppColors.black;
    final primaryColor = isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColorLight;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: dialogColor,
              title: Text(
                "Advanced Filters",
                style: TextStyle(color: textColor),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFilterDropdown(
                      value: _statusFilter,
                      items: ['Alive', 'Dead', 'Unknown'],
                      hint: 'Status',
                      textColor: textColor,
                      dialogColor: dialogColor,
                      onChanged: (value) => _statusFilter = value,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Species',
                        labelStyle: TextStyle(color: textColor),
                      ),
                      style: TextStyle(color: textColor),
                      onChanged: (value) => _speciesFilter = value.isNotEmpty ? value : null,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Type',
                        labelStyle: TextStyle(color: textColor),
                      ),
                      style: TextStyle(color: textColor),
                      onChanged: (value) => _typeFilter = value.isNotEmpty ? value : null,
                    ),
                    const SizedBox(height: 16),
                    _buildFilterDropdown(
                      value: _genderFilter,
                      items: ['Female', 'Male', 'Genderless', 'Unknown'],
                      hint: 'Gender',
                      textColor: textColor,
                      dialogColor: dialogColor,
                      onChanged: (value) => _genderFilter = value,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'CLEAR',
                    style: TextStyle(color: primaryColor),
                  ),
                  onPressed: () {
                    setState(() {
                      _statusFilter = null;
                      _speciesFilter = null;
                      _typeFilter = null;
                      _genderFilter = null;
                    });
                  },
                ),
                TextButton(
                  child: Text(
                    'APPLY',
                    style: TextStyle(color: primaryColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _applyFilters();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFilterDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required Color textColor,
    required Color dialogColor,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: dialogColor,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: textColor),
      ),
      style: TextStyle(color: textColor),
      items: [
        DropdownMenuItem(
          value: null,
          child: Text('Select $hint', style: TextStyle(color: textColor)),
        ),
        ...items.map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(item, style: TextStyle(color: textColor)),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}