import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/theme/app_colors.dart';

class NavigationDrawerComponent extends StatelessWidget {
  const NavigationDrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Drawer(
      backgroundColor: isDarkMode ? AppColors.appBarColor : AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, user),
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, User? user) {
    return FutureBuilder<DocumentSnapshot>(
      future: user != null 
          ? FirebaseFirestore.instance.collection('users').doc(user.uid).get()
          : null,
      builder: (context, snapshot) {
        String userImageBase64 = '';
        
        if (snapshot.hasData && snapshot.data?.exists == true) {
          userImageBase64 = snapshot.data?.get('photoBase64') ?? '';
        }

        return DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(userImageBase64),
              const SizedBox(height: 10),
              Text(
                'Menu',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              if (user?.email != null) ...[
                const SizedBox(height: 5),
                Text(
                  user!.email!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(String imageBase64) {
    if (imageBase64.isEmpty) {
      return const CircleAvatar(
        radius: 30,
        child: Icon(Icons.person, size: 30),
      );
    }

    try {
      return CircleAvatar(
        radius: 30,
        backgroundImage: MemoryImage(base64Decode(imageBase64)),
      );
    } catch (e) {
      debugPrint('Erro ao decodificar imagem: $e');
      return const CircleAvatar(
        radius: 30,
        child: Icon(Icons.error, size: 30),
      );
    }
  }

  Widget _buildMenuItems(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? AppColors.white : AppColors.black;
    final iconColor = isDarkMode ? AppColors.white : AppColors.black;

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.home, color: iconColor),
          title: Text('Início', 
              style: TextStyle(
                  color: textColor,
                  fontFamily: "Lato",
                  fontSize: 16)),
          trailing: Switch(
            value: false,
            activeColor: AppColors.primaryColorDark,
            onChanged: (bool value) {
            },
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, color: iconColor),
          title: Text('Configurações', 
              style: TextStyle(
                  color: textColor,
                  fontFamily: "Lato")),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
          title: Text('Sair', 
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontFamily: "Lato")),
          onTap: () {
            Navigator.popAndPushNamed(context, "/loginPage");
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}