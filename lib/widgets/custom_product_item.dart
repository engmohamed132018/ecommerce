// ignore_for_file: must_be_immutable

import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';

import '../utilits/fonts.dart';
import 'custom_text.dart';

class CustomProduct extends StatelessWidget {
  CustomProduct({super.key, required this.product, this.onTap});
  final Products product;
  AppFonts? _appFonts;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    _appFonts = AppFonts(context: context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildimage(product: product),
            _buildItemDetails(product: product),
          ],
        ),
      ),
    );
  }

  _buildimage({required Products product}) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.image!,
          width: 175,
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildItemDetails({required Products product}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        CustomeText(
          font: _appFonts!.font16,
          text: product.title!,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 3,
        ),
        CustomeText(
          font: _appFonts!.font14,
          text: product.description!,
          color: Color.fromARGB(223, 160, 160, 160),
        ),
        const SizedBox(
          height: 3,
        ),
        CustomeText(
          font: _appFonts!.font16,
          text: "\$${product.price.round()}",
          color: Colors.green,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
