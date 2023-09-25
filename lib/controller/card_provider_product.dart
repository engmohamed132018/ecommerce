import 'package:ecommerce/controller/api/product_operation.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/widgets.dart';

class ProductProvider with ChangeNotifier {
  List<Products> _provCartList = [];
  set list(List<Products> list) {
    this._provCartList = list;
  }

  double _price = 0.0;
  double totalPrice() {
    cartList.forEach((element) {
      _price += (element.price * element.cartCount);
    });
    return _price;
  }

  List<Products> get cartList => _provCartList;
  int get cartCount => _provCartList.length;
  void addItem(Products product) {
    ProductOperation.addProductToCart(product.toJson());
  }

  void deleteItem(int index) {
    final product = _provCartList.removeAt(index);
    ProductOperation.removeProductFromCart(product.id);
  }

  void deleteItemOrDecrease(int index) {
    ProductOperation.decreaseItem(index);
  }
}
