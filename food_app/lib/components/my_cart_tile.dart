import 'package:flutter/material.dart';
import 'package:food_app/components/my_quantity_selector.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../models/restaurant.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (context, restaurant, child) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        cartItem.food.imagePath,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.food.name,
                          overflow: TextOverflow.ellipsis
                        ),
                        Text('\$${cartItem.food.price}')
                      ],
                    ),
                  ],
                ),
                QuantitySelector(
                    quantity: cartItem.quantity,
                    food: cartItem.food,
                    onIncrement: () {
                      restaurant.addToCart(
                          cartItem.food,
                          cartItem.selectedAddons
                      );
                    },
                    onDecrement: () {
                      restaurant.removeFromCart(cartItem);
                    }
                ),
                SizedBox(
                  height: cartItem.selectedAddons.isEmpty ? 0 : 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                        left: 10,
                        bottom: 10,
                        right: 10
                    ),
                    children: cartItem.selectedAddons
                      .map(
                        (addon) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Row(
                              children: [
                                Text(addon.name),
                                Text(
                                  ' \$${addon.price.toString()}',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.primary
                                  ),
                                )
                              ],
                            ),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary
                              )
                            ),
                            onSelected: (value) {},
                            backgroundColor: Theme.of(context)
                                .colorScheme.secondary,
                            labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme.inversePrimary,
                              fontSize: 12
                            ),
                          ),
                        )
                      ).toList(),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
