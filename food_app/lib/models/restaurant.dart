import 'package:flutter/material.dart';
import 'package:food_app/models/food.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  List<Food> get menu => _menu;


  final List<Food> _menu = [
    // Burgers
    Food(
      name: "Classic Cheeseburger",
      description: "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
      imagePath: "lib/images/burgers/burger_1.jpg",
      price: 0.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 2.99),
      ],
    ),
    Food(
      name: "Double Bacon Burger",
      description: "Two beef patties, crispy bacon, cheddar cheese, lettuce, tomato, and special sauce.",
      imagePath: "lib/images/burgers/burger_2.jpg",
      price: 1.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Extra bacon", price: 1.99),
        Addon(name: "Jalapenos", price: 0.50),
      ],
    ),
    Food(
      name: "Mushroom Swiss Burger",
      description: "A beef patty topped with sauteed mushrooms, Swiss cheese, and garlic aioli.",
      imagePath: "lib/images/burgers/burger_3.jpg",
      price: 2.49,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra mushrooms", price: 1.00),
        Addon(name: "Caramelized onions", price: 0.75),
      ],
    ),
    // Salads
    Food(
      name: "Caesar Salad",
      description: "Crisp romaine lettuce, parmesan cheese, croutons, and creamy Caesar dressing.",
      imagePath: "lib/images/salads/salad_1.jpg",
      price: 0.79,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Grilled chicken", price: 2.99),
        Addon(name: "Avocado", price: 1.99),
        Addon(name: "Extra dressing", price: 0.50),
      ],
    ),
    Food(
      name: "Greek Salad",
      description: "Fresh cucumbers, tomatoes, red onion, Kalamata olives, feta cheese, and Greek dressing.",
      imagePath: "lib/images/salads/salad_2.jpg",
      price: 1.29,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Feta cheese", price: 0.99),
        Addon(name: "Grilled shrimp", price: 3.99),
      ],
    ),
    Food(
      name: "Cobb Salad",
      description: "Mixed greens, grilled chicken, bacon, hard-boiled egg, avocado, tomatoes, and blue cheese.",
      imagePath: "lib/images/salads/salad_3.jpg",
      price: 1.79,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra bacon", price: 1.99),
        Addon(name: "Extra avocado", price: 1.99),
      ],
    ),
    // Sides
    Food(
      name: "French Fries",
      description: "Crispy golden fries, seasoned with sea salt.",
      imagePath: "lib/images/sides/side_1.jpg",
      price: 0.49,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Cheese sauce", price: 0.79),
        Addon(name: "Chili", price: 1.29),
      ],
    ),
    Food(
      name: "Onion Rings",
      description: "Thick-cut onion rings, battered and fried to perfection.",
      imagePath: "lib/images/sides/side_2.jpg",
      price: 0.79,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Ranch dressing", price: 0.50),
        Addon(name: "Spicy mayo", price: 0.50),
      ],
    ),
    Food(
      name: "Coleslaw",
      description: "Freshly made coleslaw with shredded cabbage, carrots, and creamy dressing.",
      imagePath: "lib/images/sides/side_3.jpg",
      price: 0.39,
      category: FoodCategory.sides,
      availableAddons: [],
    ),
    // Desserts
    Food(
      name: "Chocolate Brownie",
      description: "A rich and fudgy chocolate brownie, served warm.",
      imagePath: "lib/images/desserts/dessert_1.jpg",
      price: 1.49,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Vanilla ice cream", price: 1.99),
        Addon(name: "Caramel sauce", price: 0.79),
      ],
    ),
    Food(
      name: "Apple Pie",
      description: "A classic apple pie with a flaky crust and sweet apple filling.",
      imagePath: "lib/images/desserts/dessert_2.jpg",
      price: 1.79,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Cinnamon", price: 0.25),
        Addon(name: "Whipped cream", price: 0.50),
      ],
    ),
    Food(
      name: "Ice Cream Sundae",
      description: "Vanilla ice cream with chocolate sauce, whipped cream, and a cherry on top.",
      imagePath: "lib/images/desserts/dessert_3.jpg",
      price: 1.99,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra chocolate sauce", price: 0.50),
        Addon(name: "Sprinkles", price: 0.25),
      ],
    ),
    // Drinks
    Food(
      name: "Coca-Cola",
      description: "A classic carbonated soft drink.",
      imagePath: "lib/images/drinks/drink_1.jpg",
      price: 0.29,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
    Food(
      name: "Iced Tea",
      description: "Refreshing iced tea, served with lemon.",
      imagePath: "lib/images/drinks/drink_2.jpg",
      price: 0.39,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Sweetener", price: 0.10),
      ],
    ),
    Food(
      name: "Orange Juice",
      description: "Freshly squeezed orange juice.",
      imagePath: "lib/images/drinks/drink_3.jpg",
      price: 0.59,
      category: FoodCategory.drinks,
      availableAddons: [],
    ),
  ];
}