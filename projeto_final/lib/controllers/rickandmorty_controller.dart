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

  Future<DetailedCharacter> fetchCharacterById(int id) async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character/$id'),
    );

    if (response.statusCode == 200) {
      return DetailedCharacter.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar personagem com id $id');
    }
  }

  Future<List<DetailedCharacter>> fetchCharactersByFilter({String? name, String? status, String? species, String? type, String? gender, int page = 1,}) async {
    String url = 'https://rickandmortyapi.com/api/character/?page=$page';
  
    if (name != null && name.isNotEmpty) {
      url += '&name=$name';
    }
    if (status != null) {
      url += '&status=${status.toLowerCase()}';
    }
    if (species != null) {
      url += '&species=$species';
    }
    if (type != null) {
      url += '&type=$type';
    }
    if (gender != null) {
      url += '&gender=${gender.toLowerCase()}';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> characters = data['results'];
      return characters.map((char) => DetailedCharacter.fromMap(char)).toList();
    } else {
      throw Exception("Erro durante a busca: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> fetchEpisodeByUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar episódio com URL $url');
    }
  }
}