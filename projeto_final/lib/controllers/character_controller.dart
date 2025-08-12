import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_final/models/detailed_character.dart';

class CharacterController {
  final FirebaseAuth _auth;
  final CollectionReference _charactersCollection;

  CharacterController({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _charactersCollection = (firestore ?? FirebaseFirestore.instance)
          .collection('characters');

  String? get _userId => _auth.currentUser?.uid;

  Future<void> addCharacter(DetailedCharacter character) async {
    try {
      await _charactersCollection.add({
        'id': character.id,
        'name': character.name,
        'userId': _userId,
        'imageUrl': character.image,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add character: $e');
    }
  }

  Future<void> deleteCharacter(int characterId) async {
    try {
      final query =
          await _charactersCollection
              .where('id', isEqualTo: characterId)
              .where('userId', isEqualTo: _userId)
              .limit(1)
              .get();

      if (query.docs.isEmpty) {
        throw Exception('Personagem não encontrado ou não pertence ao usuário');
      }

      await _charactersCollection.doc(query.docs.first.id).delete();
      print('Personagem deletado com sucesso');
    } catch (e) {
      throw Exception('Falha ao deletar: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUserCharacters() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return [];

      final querySnapshot =
          await _charactersCollection
              .where('userId', isEqualTo: user.uid)
              .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'name': data['name']?.toString() ?? '',
          'image': data['imageUrl']?.toString() ?? '',
        };
      }).toList();
    } catch (e) {
      print('Erro ao buscar personagens: $e');
      throw Exception('Falha ao carregar personagens');
    }
  }

  Future<DetailedCharacter> getCharacterById(String characterId) async {
    try {
      final doc = await _charactersCollection.doc(characterId).get();
      final data = doc.data() as Map<String, dynamic>?;

      if (!doc.exists || data?['userId'] != _userId) {
        throw Exception('Character not found or not owned by user');
      }
      return DetailedCharacter.fromMap({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      });
    } catch (e) {
      throw Exception('Failed to load character: $e');
    }
  }

  Future<void> updateCharacter(
    String characterId,
    DetailedCharacter character,
  ) async {
    try {
      final doc = await _charactersCollection.doc(characterId).get();
      final data = doc.data() as Map<String, dynamic>?;
      if (!doc.exists || data?['userId'] != _userId) {
        throw Exception('Character not found or not owned by user');
      }
      await _charactersCollection.doc(characterId).update(character.toMap());
    } catch (e) {
      throw Exception('Failed to update character: $e');
    }
  }

  Future<bool> characterExists(int characterId) async {
    try {
      final doc =
          await _charactersCollection
              .where('id', isEqualTo: characterId)
              .where('userId', isEqualTo: _userId)
              .limit(1)
              .get();

      return doc.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Falha ao verificar personagem: $e');
    }
  }
}
