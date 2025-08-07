import 'package:flutter/material.dart';
import 'package:projeto_final/components/appbar_component.dart';
import 'package:projeto_final/controllers/rickandmorty_controller.dart';
import 'package:projeto_final/models/detailed_character.dart';
import 'package:projeto_final/models/paginated_characters.dart';
import 'package:projeto_final/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RickandmortyController _controller = RickandmortyController();
  List<DetailedCharacter> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  final RickandmortyController rickandmortyController = RickandmortyController();

  @override
  void initState() {
    super.initState();
    _loadCharacters(); 
  }

  void _loadCharacters() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final newCharacters = await _controller.fetchCharacters(_currentPage);
      
      setState(() {
        _characters.addAll(newCharacters);
        _currentPage++;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
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
      appBar: AppBarComponent(isHomePage: true),
      backgroundColor: AppColors.backgroundColor,
      body: 
      Column(children: <Widget>[
        
      ]),
    );
  }
}