import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projeto_final/models/detailed_character.dart';

class RickandmortyController {
  Future<List<DetailedCharacter>> fetchCharacters(int page) async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> characters = data['results'];
      return characters.map((char) => DetailedCharacter.fromMap(char)).toList();
    } else {
      throw Exception("Erro durante a busca: ${response.statusCode}");
    }
  }

  Future<List<DetailedCharacter>> fetchCharactersByName(String name) async {
    if (name != null) {
      final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?name=${name}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> characters = data['results'];
        return characters
            .map((char) => DetailedCharacter.fromJson(char))
            .toList();
      } else {
        throw Exception("Erro durante a busca pelo personagem com o $name");
      }
    } else {
      throw Exception("Nome não pode ser nulo");
    }
  }

  Future<DetailedCharacter> fetchCharacterById(int id) async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));
    
    if (response.statusCode == 200) {
      return DetailedCharacter.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar personagem com id $id');
    }
  }


  Future<List<DetailedCharacter>> fetchCharactersByFilter(
    String name,
    String filtro,
  ) async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character/'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> characters = data['results'];
      return characters.map((char) => DetailedCharacter.fromMap(char)).toList();
    } else {
      throw Exception("Erro durante a busca: ${response.statusCode}");
    }
  }
}
