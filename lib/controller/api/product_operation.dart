import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:ecommerce/controller/contrroler_auth/auth.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductOperation {
  static final _firebaseStor = FirebaseFirestore.instance;
  static final String _currentUserId = Auth.getUserId();
  static const String cart = 'Cart';
  static const String cartProducts = 'products';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCartProducts() {
    return _firebaseStor
        .collection(cart)
        .doc(_currentUserId)
        .collection(cartProducts)
        .snapshots();
  }

  static void addProductToCart(Map<String, dynamic> products) async {
    try {
      await _firebaseStor
          .collection(cart)
          .doc(_currentUserId)
          .collection(cartProducts)
          .get()
          .then((value) async {
        if (value.docs.isEmpty) {
          await _firebaseStor
              .collection(cart)
              .doc(_currentUserId)
              .collection(cartProducts)
              .doc(products['id'].toString())
              .set(products);
        } else {
          for (var element in value.docs) {
            if (element.id == products['id'].toString()) {
              products["cartCount"] = products['cartCount'] + 1;
              await _firebaseStor
                  .collection(cart)
                  .doc(_currentUserId)
                  .collection(cartProducts)
                  .doc(products['id'].toString())
                  .update(products);
            } else {
              await _firebaseStor
                  .collection(cart)
                  .doc(_currentUserId)
                  .collection(cartProducts)
                  .doc(products['id'].toString())
                  .set(products);
            }
          }
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static removeProductFromCart(int id) async {
    await _firebaseStor
        .collection(cart)
        .doc(_currentUserId)
        .collection(cartProducts)
        .doc(id.toString())
        .delete();
  }

  static void decreaseItem(int id) async {
    try {
      await _firebaseStor
          .collection(cart)
          .doc(_currentUserId)
          .collection(cartProducts)
          .doc(id.toString())
          .get()
          .then((value) {
        if (value.data()!['cartCount'] > 1) {
          _firebaseStor
              .collection(cart)
              .doc(_currentUserId)
              .collection(cartProducts)
              .doc(id.toString())
              .update({'cartCount': value.data()!['cartCount'] - 1});
        } else {
          removeProductFromCart(id);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
