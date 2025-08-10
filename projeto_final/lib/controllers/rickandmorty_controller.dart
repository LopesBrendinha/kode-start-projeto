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

  Future<List<DetailedCharacter>> fetchCharactersByName(String name, int page,) async {
    final response = await http.get(
      Uri.parse(
        'https://rickandmortyapi.com/api/character/?name=$name&page=$page',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['results'] != null) {
        final List<dynamic> characters = data['results'];
        print(data['result']);
        return characters
            .map((char) => DetailedCharacter.fromJson(char))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Erro durante a busca pelo personagem com o nome $name");
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

  Future<Map<String, dynamic>> fetchEpisodeByUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar episódio com URL $url');
    }
  }
}
