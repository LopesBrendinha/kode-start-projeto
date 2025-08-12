import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/theme_controller.dart';
import 'package:projeto_final/theme/app_colors.dart';
import 'package:provider/provider.dart';

class NavigationDrawerComponent extends StatelessWidget {
  const NavigationDrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? AppColors.appBarColor : AppColors.white;
    final headerColor =
        isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColorLight;

    return Drawer(
      backgroundColor: backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(
              context,
              FirebaseAuth.instance.currentUser,
              headerColor,
            ),
            _buildMenuItems(context, backgroundColor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, User? user, Color headerColor) {
    return FutureBuilder<DocumentSnapshot>(
      future:
          user != null
              ? FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get()
              : null,
      builder: (context, snapshot) {
        String userImageBase64 =
            snapshot.hasData && snapshot.data?.exists == true
                ? snapshot.data?.get('photoBase64') ?? ''
                : '';

        return Container(
          decoration: BoxDecoration(color: headerColor),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(userImageBase64),
              const SizedBox(height: 10),
              Text(
                'Menu',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
              if (user?.email != null) ...[
                const SizedBox(height: 5),
                Text(
                  user!.email!,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: 14,
                    fontFamily: "Lato",
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
      return CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.white,
        child: Icon(Icons.person, size: 30, color: AppColors.primaryColorDark),
      );
    }

    try {
      return CircleAvatar(
        radius: 30,
        backgroundImage: MemoryImage(base64Decode(imageBase64)),
      );
    } catch (e) {
      debugPrint('Erro ao decodificar imagem: $e');
      return CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.white,
        child: Icon(Icons.error, size: 30, color: AppColors.red),
      );
    }
  }

  Widget _buildMenuItems(BuildContext context, Color backgroundColor) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? AppColors.white : AppColors.black;
    final iconColor = isDarkMode ? AppColors.white : AppColors.black;

    return Column(
      children: [
        ListTile(
          leading: Icon(
            context.watch<ThemeController>().isDarkMode
                ? Icons.nightlight_round
                : Icons.wb_sunny,
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text(
            context.watch<ThemeController>().isDarkMode
                ? 'Tema Escuro'
                : 'Tema Claro',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontFamily: "Lato",
            ),
          ),
          trailing: Switch(
            value: context.watch<ThemeController>().isDarkMode,
            activeColor: AppColors.primaryColorDark,
            inactiveTrackColor: AppColors.gray,
            onChanged: (bool value) {
              context.read<ThemeController>().toggleTheme(value);
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.settings, color: iconColor),
          title: Text(
            'Configurações',
            style: TextStyle(
              color: textColor,
              fontFamily: "Lato",
              fontSize: 16,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/settingsPage");
          },
        ),
        Divider(color: isDarkMode ? AppColors.gray : AppColors.lightGray),
        ListTile(
          leading: Icon(Icons.logout, color: AppColors.red),
          title: Text(
            'Sair',
            style: TextStyle(
              color: AppColors.red,
              fontFamily: "Lato",
              fontSize: 16,
            ),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, "/loginPage");
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}
