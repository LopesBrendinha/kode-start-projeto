import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/components/appbar_component.dart';
import 'package:projeto_final/components/card_character_component.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/views/details_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  String _userName = '';
  String _userEmail = '';
  String _userImageBase64 = '';
  List<Map<String, dynamic>> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
  setState(() => _isLoading = true);

  try {
    _user = _auth.currentUser;

    if (_user != null) {
      _userEmail = _user!.email ?? '';

      final userDoc = await _firestore.collection('users').doc(_user!.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc.data()?['name'] ?? 'Sem nome';
          _userImageBase64 = userDoc.data()?['photoBase64'] ?? '';
        });
      }

      final favoritesSnapshot = await _firestore
          .collection('users')
          .doc(_user!.uid)
          .collection('favorites')
          .get();

      setState(() {
        _favorites = favoritesSnapshot.docs
            .map((doc) => {
                  'id': int.parse(doc.id), 
                  'name': doc.data()['characterName'] as String,
                  'image': doc.data()['characterImage'] as String,
                })
            .toList();
      });
    }
  } catch (e) {
    print('Erro ao carregar dados: $e');
  } finally {
    setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        isHomePage: false,
        onTap: () {},
        onTap2: () {},
        isProfilePage: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.appBarColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildProfileImage(),
                          const SizedBox(height: 16),
                          Text(
                            _userName,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Lato",
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _userEmail,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Lato",
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Meus Favoritos",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Lato",
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _favorites.isEmpty
                              ? Center(
                                child: Text(
                                  "Nenhum favorito adicionado",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Lato",
                                    color: AppColors.white,
                                  ),
                                ),
                              )
                              : _favorites.isEmpty
                              ? Center(
                                child: Text(
                                  "Nenhum favorito adicionado",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Lato",
                                    color: AppColors.white,
                                  ),
                                ),
                              )
                              : ExpansionTile(
                                title: Text(
                                  "Personagens Favoritos (${_favorites.length})",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                collapsedIconColor: AppColors.white,
                                iconColor: AppColors.white,
                                children:
                                    _favorites.map((fav) {
                                      return CardCharacterComponent(
                                        characterName: fav['name'],
                                        characterImg: fav['image'],
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => DetailsPage(
                                                    characterId: int.parse(
                                                      fav['id'].toString(),
                                                    ),
                                                  ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildProfileImage() {
    if (_userImageBase64.isEmpty) {
      return const Icon(Icons.person, size: 50);
    }

    try {
      return CircleAvatar(
        radius: 50,
        backgroundImage: MemoryImage(base64Decode(_userImageBase64)),
      );
    } catch (e) {
      print('Erro ao decodificar imagem: $e');
      return const Icon(Icons.error, size: 50);
    }
  }
}
