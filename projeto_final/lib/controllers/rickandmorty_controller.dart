import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projeto_final/models/detailed_character.dart';


class RickandmortyController {
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

  Future<List<DetailedCharacter>> fetchCharacterByName(String name) async {
    if(name != null){
      final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/?name=${name}'));
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        final List<dynamic> characters = data['results'];
        return characters.map((char)=> DetailedCharacter.fromJson(char)).toList();
      }else{
        throw Exception("Erro durante a busca pelo personagem com o $name");
      }
    }else{
      throw Exception("Nome não pode ser nulo");
    }
    
  }


}
