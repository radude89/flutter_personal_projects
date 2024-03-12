import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/cupertino.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(
      name: "Zoom Freak",
      price: "236",
      imagePath: "lib/images/nike_1.png",
      description: "Shoes 1"
    ),
    Shoe(
      name: "Air Jordans",
      price: "220",
      imagePath: "lib/images/nike_2.png",
      description: "Shoes 2"
    ),
    Shoe(
      name: "KD Treys",
      price: "240",
      imagePath: "lib/images/nike_3.png",
      description: "Shoes 3"
    ),
    Shoe(
      name: "Kyrie 6",
      price: "236",
      imagePath: "lib/images/nike_4.png",
      description: "Shoes 4"
    ),
  ];

  List<Shoe> userCart = [];

  List<Shoe> getShoeList() {
    return shoeShop;
  }

  List<Shoe> getUserCart() {
    return userCart;
  }

  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  void removeItemFromCart(shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
