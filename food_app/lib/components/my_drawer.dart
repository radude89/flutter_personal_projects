import 'package:flutter/material.dart';
import 'package:food_app/components/my_drawer_tile.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          
          MyDrawerTile(
            text: "HOME",
            iconData: Icons.home,
            onTap: () => Navigator.pop(context)
          ),

          MyDrawerTile(
              text: "SETTINGS",
              iconData: Icons.settings,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage()
                  )
                );
              }
          ),

          const Spacer(),

          MyDrawerTile(
              text: "LOGOUT",
              iconData: Icons.logout,
              onTap: () {}
          ),

          const SizedBox(height: 25)
        ],
      ),
    );
  }
}
