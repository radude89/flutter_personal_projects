import 'package:flutter/material.dart';
import 'package:music_player/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.music_note,
                  size: 40,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .inversePrimary,
                ),
              )
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              title: const Text("Settings"),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage()
                  )
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
