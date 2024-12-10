import 'package:commerce/home.dart';
import 'package:flutter/material.dart';
//adddddd
class Cart with ChangeNotifier {
  List selectedProducts = [];
  int price = 0;

  add(item product) {
    selectedProducts.add(product);
    price += product.price.round();
    notifyListeners();
  }
  delete(item product) {
    selectedProducts.remove(product);
    price -= product.price.round();
    notifyListeners();
  }


}