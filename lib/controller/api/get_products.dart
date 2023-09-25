import 'dart:convert';

import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl =
      "https://eecommerce-c229f-default-rtdb.firebaseio.com/product.json";

  static Future<List<Products>> getProducts() async {
    List<Products> list = [];
    try {
      final respons = await http.get(Uri.parse(baseUrl));
      if (respons.statusCode == 200) {
        final List data = jsonDecode(respons.body);
        return list = data.map((e) => Products.fromJson(e)).toList();
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }
}
