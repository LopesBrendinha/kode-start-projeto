import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:projeto_final/components/appbar_component.dart';
import 'package:projeto_final/components/card_character_component.dart';
import 'package:projeto_final/controllers/character_controller.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:projeto_final/views/details_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CharacterController _characterController = CharacterController();

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
    _loadFavorites();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      _user = _auth.currentUser;
      if (_user == null) return;

      _userEmail = _user!.email ?? '';

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _userName = userDoc.data()?['name'] ?? translate('profile.no_name');
          _userImageBase64 = userDoc.data()?['photoBase64'] ?? '';
        });
      }
    } catch (e) {
      debugPrint('${translate('profile.errors.load_user')}: $e');
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final favorites = await _characterController.getUserCharacters();
      setState(() {
        _favorites = favorites;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('${translate('profile.errors.load_favorites')}: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundColor : AppColors.lightBackgroundColor;
    final headerColor = isDarkMode ? AppColors.appBarColor : AppColors.primaryColorLight;
    final textColor = isDarkMode ? AppColors.white : AppColors.black;
    final progressColor = isDarkMode ? AppColors.white : AppColors.primaryColorDark;

    return Scaffold(
      appBar: AppBarComponent(
        isHomePage: false,
        onTap: () {},
        onTap2: () {},
        isProfilePage: true,
      ),
      backgroundColor: backgroundColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: progressColor),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: headerColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildProfileImage(isDarkMode),
                        const SizedBox(height: 16),
                        Text(
                          _userName,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: "Lato",
                            color: textColor,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _userEmail,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Lato",
                            color: textColor,
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
                          translate('profile.favorites_title'),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: "Lato",
                            color: textColor,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _favorites.isEmpty
                            ? Center(
                                child: Text(
                                  translate('profile.no_favorites'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Lato",
                                    color: textColor,
                                  ),
                                ),
                              )
                            : ExpansionTile(
                                title: Text(
                                  translate('profile.favorite_characters', args: {'count': _favorites.length}),
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Lato",
                                  ),
                                ),
                                collapsedIconColor: textColor,
                                iconColor: textColor,
                                children: _favorites.map((fav) {
                                  return CardCharacterComponent(
                                    characterName: fav['name'] ?? '',
                                    characterImg: fav['image'] ?? '',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                            characterId: fav['id'] as int,
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

  Widget _buildProfileImage(bool isDarkMode) {
    if (_userImageBase64.isEmpty) {
      return CircleAvatar(
        radius: 50,
        backgroundColor: isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColorLight,
        child: Icon(
          Icons.person,
          size: 50,
          color: AppColors.white,
        ),
      );
    }

    try {
      return CircleAvatar(
        radius: 50,
        backgroundImage: MemoryImage(base64Decode(_userImageBase64)),
      );
    } catch (e) {
      debugPrint('${translate('profile.errors.image_decode')}: $e');
      return CircleAvatar(
        radius: 50,
        backgroundColor: isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColorLight,
        child: Icon(
          Icons.error,
          size: 50,
          color: AppColors.white,
        ),
      );
    }
  }
}