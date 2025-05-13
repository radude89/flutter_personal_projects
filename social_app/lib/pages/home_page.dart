import 'package:flutter/material.dart';
import 'package:social_app/components/default_drawer.dart';
import 'package:social_app/utils/context_theme_ext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void openPostMessageBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Post"),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      drawer: DefaultDrawer(),
      appBar: AppBar(
        title: const Text("Home"),
        foregroundColor: context.colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openPostMessageBox,
        child: const Icon(Icons.add),
      ),
    );
  }
}
