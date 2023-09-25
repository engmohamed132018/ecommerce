// ignore_for_file: must_be_immutable

import 'package:ecommerce/controller/cart_index_provider.dart';
import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'address_part.dart';
import 'delivery_part.dart';

class DeleveryScreen extends StatelessWidget {
  DeleveryScreen({super.key});
  AppFonts? appFonts;
  List<Widget> list = [
    DeliveryPart(),
    AddressPart(),
    DeliveryPart(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildSteperPart(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomeText(font: appFonts!.font14, text: 'delivery'),
                CustomeText(font: appFonts!.font14, text: 'address'),
                CustomeText(font: appFonts!.font14, text: 'summer'),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: list.elementAt(context.watch<IndexProvider>().index),
            )
          ],
        ),
      ),
    );
  }

  buildSteperPart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          buildCircleItem('delivery', Colors.green),
          const Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          buildCircleItem(
              'address', index >= 1 ? Colors.green : Colors.transparent),
          const Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          buildCircleItem(
              'summer', index == 2 ? Colors.green : Colors.transparent),
        ],
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
            title: CustomeText(
                font: appFonts!.font18,
                text: index > 1 ? 'summer' : 'Checkout'),
            centerTitle: true,
          )),
    );
  }

  buildCircleItem(text, color) {
    return buildCir(color);
  }

  buildCir(color) {
    return Container(
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
          )),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: color,
      ),
    );
  }
}
