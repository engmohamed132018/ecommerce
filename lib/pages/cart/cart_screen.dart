import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/controller/api/get_products.dart';
import 'package:ecommerce/controller/api/product_operation.dart';
import 'package:ecommerce/controller/card_provider_product.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/pages/checkout/delevery.dart';
import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/custom_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../widgets/custome_button.dart';

class CartItem extends StatefulWidget {
  CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  AppFonts? appFonts;
  @override
  void initState() {
    super.initState();
  }

  //  List<Product> items=[];
  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Builder(builder: (context) {
      return Stack(
        children: [
          buildMainItem(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildBottomBody(),
          ),
        ],
      );
    });
  }

  buildMainItem(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ProductOperation.getCartProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            context.watch<ProductProvider>().list = data
                .map((e) => Products.fromJson(e.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final items = context.read<ProductProvider>().cartList;

                return buildListItem(
                    product: items[index], index: index, context: context);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget buildListItem(
      {required Products product,
      required int index,
      required BuildContext context}) {
    return Slidable(
      dragStartBehavior: DragStartBehavior.start,
      key: ObjectKey(product),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          buildDismissLeft(product, index),
        ],
      ),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        buildDismissRight(product, index),
      ]),
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image!,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(product.title!,
                        style: TextStyle(
                            fontSize: appFonts!.font16,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis),
                  ),
                  CustomeText(
                    font: appFonts!.font16,
                    text: "\$${product.price}",
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildIcrDecPart(
                      product: product, index: index, context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildIcrDecPart(
      {required Products product,
      required int index,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[300],
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildicon(
              iconData: Icons.add,
              onClicked: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .addItem(product);
              }),
          Consumer<ProductProvider>(builder: (context, product, child) {
            return CustomeText(
                font: appFonts!.font14,
                text: product.cartList[index].cartCount.toString());
          }),
          buildicon(
            iconData: Icons.remove,
            onClicked: () {
              Provider.of<ProductProvider>(context, listen: false)
                  .deleteItemOrDecrease(product.id);
            },
          ),
        ],
      ),
    );
  }

  buildicon({required IconData iconData, required VoidCallback onClicked}) {
    return ClipOval(
      child: IconButton(
        onPressed: onClicked,
        icon: Icon(
          iconData,
          size: 12,
        ),
      ),
    );
  }

  buildBottomBody() {
    return Container(
      height: 84,
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildPrice(),
          Spacer(),
          Builder(builder: (context) {
            return CustomeButton(
                appFonts: appFonts!.font16,
                text: 'CHECKOUT',
                size: Size(150, 50),
                onClicked: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => DeleveryScreen()));
                });
          }),
        ],
      ),
    );
  }

  buildPrice() {
    return Consumer<ProductProvider>(builder: (context, produc, child) {
      double price = 0.0;
      for (var element in produc.cartList) {
        price += (element.price * element.cartCount);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomeText(
            font: 12,
            text: price == 0 ? "" : 'price',
            color: Colors.grey[500]!,
          ),
          CustomeText(
            font: appFonts!.font18,
            text: price == 0 ? "" : '$price',
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ],
      );
    });
  }

  buildDismissLeft(Products product, int index) {
    return SlidableAction(
      onPressed: (context) => onClickedLeft(product),
      backgroundColor: Colors.yellow,
      foregroundColor: Colors.white,
      icon: Icons.star,
    );
  }

  buildDismissRight(Products product, int index) {
    return SlidableAction(
      onPressed: (context) => onClickedRight(index, context),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      icon: Icons.delete_forever_outlined,
    );
  }

  onClickedRight(int index, context) async {
    Provider.of<ProductProvider>(context, listen: false).deleteItem(index);
  }

  onClickedLeft(Products product) {}
}
