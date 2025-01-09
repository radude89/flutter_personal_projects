import 'package:flutter/material.dart';

import '../models/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.name),
                        Text(
                          '\$${food.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          )
                        ),
                        const SizedBox(height: 10),
                        Text(
                          food.description,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary
                          ),
                        )
                      ]
                    )
                ),
                const SizedBox(width: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(food.imagePath, height: 100)
                )
              ]
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
          endIndent: 25,
          indent: 25,
        )
      ],
    );
  }
}
