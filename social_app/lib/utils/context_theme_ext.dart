import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/themes/theme_provider.dart';

extension ThemeExtensions on BuildContext {
  ColorScheme get colorScheme =>
      Theme.of(this).colorScheme;

  ThemeData get themeData =>
      Provider.of<ThemeProvider>(this).themeData;
}