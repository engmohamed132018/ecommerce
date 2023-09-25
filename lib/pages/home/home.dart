import 'package:ecommerce/controller/api/get_products.dart';
import 'package:ecommerce/controller/api_provider.dart';
import 'package:ecommerce/model/category.dart';
import 'package:ecommerce/model/category_result.dart';
import 'package:ecommerce/pages/home/product_details.dart';
import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/main_bar.dart';
import '../../model/product_model.dart';
import '../../widgets/custom_product_item.dart';

enum Category {
  electronics,
  jewelery,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppFonts? _appFonts;
  @override
  Widget build(BuildContext context) {
    _appFonts = AppFonts(context: context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          _buildSearch(),
          const SizedBox(
            height: 40,
          ),
          _buildtextCategory(),
          const SizedBox(
            height: 24,
          ),
          _buildCategory(),
          const SizedBox(
            height: 40,
          ),
          _buildBestSellRow(),
          const SizedBox(
            height: 24,
          ),
          _buildmainList()
        ],
      ),
    );
  }

  CustomeText _buildtextCategory() {
    return CustomeText(
      font: _appFonts!.font18,
      text: 'Categories',
      fontWeight: FontWeight.bold,
    );
  }

  _buildSearch() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.grey.withOpacity(.2),
            filled: true,
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search)),
      ),
    );
  }

  Widget _buildCategory() {
    List<CategoryModel> catlist = [
      CategoryModel(title: "men's clothing", imgUrl: 'assets/icons/ic10.png'),
      CategoryModel(title: "women's clothing", imgUrl: 'assets/icons/ic7.png'),
      CategoryModel(
          title: Category.electronics.name, imgUrl: 'assets/icons/ic2.png'),
      CategoryModel(
          title: Category.jewelery.name, imgUrl: 'assets/icons/ic4.png'),
    ];

    return Container(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: catlist.map((CategoryModel e) => buildCatItem(e)).toList(),
      ),
    );
  }

  Widget buildCatItem(CategoryModel e) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CategoryResult(
                      catModel: e,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(.009),
                      blurRadius: 2,
                      spreadRadius: 5,
                      offset: Offset(1, 7)),
                ],
              ),
              child: Image.asset(
                e.imgUrl,
                width: 26,
                height: 26,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomeText(font: _appFonts!.font14, text: e.title),
          ],
        ),
      ),
    );
  }

  _buildBestSellRow() {
    return Row(
      children: [
        CustomeText(
          font: _appFonts!.font18,
          text: 'Best Selling',
          fontWeight: FontWeight.bold,
        ),
        Spacer(),
        TextButton(
            onPressed: () {},
            child: CustomeText(
              font: _appFonts!.font16,
              text: 'see all',
            ))
      ],
    );
  }

  _buildmainList() {
    return Expanded(
        child: FutureBuilder<List<Products>>(
            future: Api.getProducts(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                context.watch<ApiProvider>().fetchData(snapShot.data!);
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapShot.data!.length,
                    itemBuilder: (context, index) {
                      final Products product = snapShot.data![index];
                      return CustomProduct(
                        product: product,
                        onTap: () {
                          onItemTap(product);
                        },
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            }));
  }

  buildNavigationBar() {
    return BottomMainBarItem(appFonts: _appFonts);
  }

  void onItemTap(Products product) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => ProductDetails(product: product)));
  }
}
