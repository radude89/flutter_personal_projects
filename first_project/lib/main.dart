import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
              "My App Bar",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          leading: const Icon(
              Icons.menu,
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                    Icons.logout,
                  color: Colors.white,
                )
            )
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => const ListTile(
            title: Text("🐙")
          ),
        ),
      ),
    );
  }
}