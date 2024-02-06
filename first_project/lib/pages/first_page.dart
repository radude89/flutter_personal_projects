// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("1st page"),
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: Column(
          children: [
            DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  size: 48,
                ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("HOME"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/homepage');
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("SETTINGS"),
              onTap: () {
                Navigator.pushNamed(context, '/settingspage');
              },
            )
          ],
        ),
      ),
    );
  }
}