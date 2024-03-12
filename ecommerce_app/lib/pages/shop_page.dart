import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SearchBar
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search', style: TextStyle(color: Colors.grey)),
              Icon(Icons.search, color: Colors.grey)
            ],
          )
        ),
        // Message
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            'Everyone files... some fly longer than others',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        // Hot Picks
        const Row(children: [
          Text(
            'Hot Picks 🔥',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          )
        ])
      ],
    );
  }
}
