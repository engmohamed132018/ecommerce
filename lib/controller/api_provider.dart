import 'package:ecommerce/controller/api/get_products.dart';
import 'package:flutter/widgets.dart';

import '../model/product_model.dart';

class ApiProvider with ChangeNotifier {
  List<Products> apiListProduct = [];
  void fetchData(List<Products> data) async {
    apiListProduct = data;
  }
}
