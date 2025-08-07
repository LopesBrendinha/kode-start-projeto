import 'package:flutter/material.dart';

class NavigationDrawerComponent extends StatelessWidget {
  const NavigationDrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.abc_outlined),
              title: Text('Rosa'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
