// ignore_for_file: must_be_immutable

import 'package:ecommerce/controller/api/product_operation.dart';
import 'package:ecommerce/controller/card_provider_product.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/custom_text.dart';
import 'package:ecommerce/widgets/custome_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.product});
  AppFonts? appFonts;
  final Products product;
  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(),
            buildBody(),
            buildButtomPart(),
          ],
        ),
      ),
    );
  }

  Container buildBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(),
          const SizedBox(
            height: 20,
          ),
          buildSizeColorBart(),
          const SizedBox(
            height: 32,
          ),
          CustomeText(
            font: appFonts!.font18,
            text: 'Details',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          buildTextPart(),
        ],
      ),
    );
  }

  Container buildImage() {
    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(product.image!.toString()),
              fit: BoxFit.cover)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios));
            }),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Icon(Icons.star_border),
                  backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  buildTitle() {
    return CustomeText(font: appFonts!.font30, text: product.title!);
  }

  buildSizeColorBart() {
    return Row(
      children: [
        buildSizeItem(),
        Spacer(),
        buildColorItem(),
      ],
    );
  }

  buildSizeItem() {
    return Container(
      width: 160,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomeText(font: appFonts!.font14, text: 'Size'),
          CustomeText(
            font: appFonts!.font16,
            text: 'XL',
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  buildColorItem() {
    return Container(
      width: 160,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomeText(font: appFonts!.font14, text: 'Colour'),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Color(0xff31407B),
              border: Border.all(color: Colors.grey[100]!, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  buildTextPart() {
    return Container(
      height: 225,
      child: SingleChildScrollView(
        child: Text(
          product.description!,
          style: TextStyle(height: 3),
        ),
      ),
    );
  }

  buildButtomPart() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildPrice(),
          Builder(builder: (context) {
            return CustomeButton(
                appFonts: appFonts!.font16,
                text: 'ADD',
                size: Size(150, 50),
                onClicked: () async {
                  ProductOperation.addProductToCart(product.toJson());
                  final SnackBar snackBar =
                      SnackBar(content: Text('product added to cart'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
          }),
        ],
      ),
    );
  }

  Column buildPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomeText(
          font: 12,
          text: 'price',
          color: Colors.grey[500]!,
        ),
        CustomeText(
          font: appFonts!.font18,
          text: '\$${product.price}',
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
