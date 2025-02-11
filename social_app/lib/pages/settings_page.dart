import 'package:flutter/material.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: const Text("Settings"),
        foregroundColor: context.colorScheme.primary,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
