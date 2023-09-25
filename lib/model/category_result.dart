import 'package:ecommerce/controller/api_provider.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/pages/home/product_details.dart';
import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/custom_product_item.dart';
import 'package:ecommerce/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category.dart';

// ignore: must_be_immutable
class CategoryResult extends StatelessWidget {
  CategoryResult({super.key, required this.catModel});
  AppFonts? appFonts;
  final CategoryModel catModel;

  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            buildbart(),
            buildMainWidget(context),
          ],
        ),
      ),
    );
  }

  buildbart() {
    return SizedBox(
      height: 130,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            BackButton(),
            const SizedBox(
              width: 150,
            ),
            CustomeText(font: 20, text: catModel.title!),
          ],
        ),
      ),
    );
  }

  buildMainWidget(BuildContext context) {
    // print(Provider.of<ApiProvider>(context).apiListProduct);
    final data = Provider.of<ApiProvider>(context).apiListProduct;
    final list =
        data.where((element) => element.category == catModel.title).toList();
    print(list);

    return Expanded(
        child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final product = list[index];
              if (index % 2 == 0 && index > 0 || index % 3 == 0 && index > 0) {
                return MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetails(product: product)));
                  },
                  child: Stack(
                    children: [
                      CustomProduct(
                        product: product,
                      ),
                      Positioned(
                        top: 10,
                        right: 20,
                        child: Container(
                          width: 50,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xFFE80057),
                          ),
                          child: const Center(
                            child: CustomeText(
                              font: 12,
                              text: 'New',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetails(product: product)));
                  },
                  child: CustomProduct(
                    product: product,
                  ),
                );
              }
            }));
  }
}
