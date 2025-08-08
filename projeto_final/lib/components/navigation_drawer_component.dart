import 'package:flutter/material.dart';
import 'package:projeto_final/theme/app_colors.dart';

class NavigationDrawerComponent extends StatelessWidget {
  const NavigationDrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.appBarColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.abc_outlined, color: AppColors.white),
              title: Text('Rosa'),
              onTap: () {
    
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
