import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/login_page.dart';
import 'package:social_app/themes/theme_provider.dart';
import 'package:social_app/utils/context_theme_ext.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: context.themeData,
    );
  }
}