
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import '../services/auth/auth_service.dart';
import 'default_drawer_tile.dart';

class DefaultDrawer extends StatelessWidget {
  DefaultDrawer({super.key});

  final _auth = AuthService();

  void logout() async {
    try {
      await _auth.logout();
    } catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colorScheme.surface,
      child: createDrawerChild(context)
    );
  }

  Widget createDrawerChild(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 25.0);
    return Padding(
      padding: padding,
      child: SafeArea(
        child: Column(
          children: createContent(context),
        ),
      ),
    );
  }

  List<Widget> createContent(BuildContext context) {
    List<Widget> content = [
      appLogo(context),
      createDivider(context),
      createSpacer(10)
    ];
    content.addAll(createTiles(context));
    return content;
  }

  List<Widget> createTiles(BuildContext context) {
    List<Widget> allTiles = [];
    allTiles.addAll(createMainTiles(context));
    allTiles.addAll([
        const Spacer(),
        createTile("Logout", Icons.logout, logout),
        SizedBox(height: 25)
    ]);
    return allTiles;
  }

  List<Widget> createMainTiles(BuildContext context) {
    return [
      createTile("Home", Icons.home, () {
        pop(context);
      }),
      createTile("Profile", Icons.person, () {
        onTapProfile(context);
      }),
      createTile("Settings", Icons.settings, () {
        onTapSettings(context);
      }),
    ];
  }

  DefaultDrawerTile createTile(
    String title,
    IconData icon,
    void Function () onTap
  ) {
    return DefaultDrawerTile(
      title: title,
      icon: icon,
      onTap: onTap
    );
  }

  Divider createDivider(BuildContext context) {
    return Divider(
      color: context.colorScheme.secondary,
    );
  }

  Widget createSpacer(double height) {
    return SizedBox(height: height);
  }

  Padding appLogo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Icon(
        Icons.person,
        size: 72,
        color: context.colorScheme.primary,
      ),
    );
  }
}

// region Navigation helpers
extension DrawerNavExtensions on DefaultDrawer {
  void push(Widget page, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page)
    );
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
// endregion

// region Selectors
extension DrawerExtensions on DefaultDrawer {
  void onTapSettings(BuildContext context) {
    pop(context);
    push(const SettingsPage(), context);
  }

  void onTapProfile(BuildContext context) {
    pop(context);
    push(
        ProfilePage(uid: _auth.getCurrentUid()),
        context
    );
  }
}
// endregion
