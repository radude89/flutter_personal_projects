import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/default_settings_tile.dart';
import 'package:social_app/themes/theme_provider.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.themeProvider;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: const Text("Settings"),
        foregroundColor: context.colorScheme.primary,
      ),
      body: Column(
        children: [
          DefaultSettingsTile(
            title: "Dark Mode",
            action: createSwitch(themeProvider)
          )
        ],
      ),
    );
  }

  Widget createSwitch(ThemeProvider themeProvider) {
    return CupertinoSwitch(
        value: themeProvider.isDarkMode,
        onChanged: (bool? value) => setState(() {
          themeProvider.toggleTheme();
        })
    );
  }
}
