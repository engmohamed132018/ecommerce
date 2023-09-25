// ignore_for_file: must_be_immutable

import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/custom_product_item.dart';
import 'package:ecommerce/widgets/custome_button.dart';
import 'package:ecommerce/widgets/custome_out_line_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/card_provider_product.dart';
import '../../widgets/custom_text.dart';

class SummerPart extends StatelessWidget {
  SummerPart({super.key});
  AppFonts? appFonts;
  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: context.read<ProductProvider>().cartList.length,
                itemBuilder: (context, index) {
                  final item = context.read<ProductProvider>().cartList[index];
                  return CustomProduct(product: item);
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomeText(
              font: appFonts!.font18,
              text: 'Shipping Address',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 286,
              child: CustomeText(
                  font: appFonts!.font16,
                  text:
                      '21, Alex Davidson Avenue, Opposite Omegatron, Vicent Smith Quarters, Victoria Island, Lagos, Nigeria'),
            ),
            TextButton(
                onPressed: () {},
                child: CustomeText(
                  font: appFonts!.font14,
                  color: Colors.green,
                  text: 'change',
                )),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomOutLineButton(
                        onClicked: () {},
                      ),
                      CustomeButton(
                        appFonts: appFonts!.font16,
                        text: 'deliver',
                        size: Size(150, 50),
                        onClicked: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Container(),
      elevation: 0,
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            leading: BackButton(),
            title: CustomeText(font: appFonts!.font18, text: 'summer'),
            centerTitle: true,
          )),
    );
  }
}
