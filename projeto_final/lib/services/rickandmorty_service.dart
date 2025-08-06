import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projeto_final/models/detailed_character.dart';


class RickandmortyService {
  Future<List<DetailedCharacter>> fetchCharacters(int page) async {
    http.Response response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'));
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      final List<dynamic> characters = data['results'];
      return characters.map((char)=> DetailedCharacter.fromJson(char)).toList();
    }else{
      throw Exception("Erro durante a busca");
    }
  }

  Future<DetailedCharacter> fetchCharacterById(int id) async {
    http.Response response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return DetailedCharacter.fromJson(data);
    }else{
      throw Exception("Erro durante a busca pelo personagem com id $id");
    }
  }

}
