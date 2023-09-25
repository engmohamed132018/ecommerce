import 'package:ecommerce/controller/nav_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilits/fonts.dart';
import 'custom_text.dart';

class BottomMainBarItem extends StatelessWidget {
  BottomMainBarItem({
    super.key,
    required AppFonts? appFonts,
  }) : _appFonts = appFonts;

  final AppFonts? _appFonts;

  @override
  Widget build(BuildContext context) {
    return Selector<NavBarProvider, int>(
      selector: (coontext, navBarprov) => navBarprov.index,
      builder: (context, value, child) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarItem(
              value: value,
              font: _appFonts!.font14,
              text: 'Explore',
              img: 'assets/icons/ic11.png',
              index: 0,
            ),
/////////////secand item
            NavBarItem(
              value: value,
              font: _appFonts!.font14,
              text: 'Cart',
              img: 'assets/icons/ic1.png',
              index: 1,
            ),
            ////thirditem
            NavBarItem(
              value: value,
              font: _appFonts!.font14,
              text: 'profile',
              img: 'assets/icons/ic9.png',
              index: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.value,
    required this.font,
    required this.text,
    required this.img,
    required this.index,
  });
  final int value;
  final double font;
  final String text;
  final String img;
  final int index;

  @override
  Widget build(BuildContext context) {
    return value == index
        ? CustomeText(
            font: font,
            text: text,
            fontWeight: FontWeight.bold,
          )
        : GestureDetector(
            onTap: () =>
                context.read<NavBarProvider>().changvalue(index: index),
            child: Image.asset(
              img,
              width: 20,
              height: 20,
            ),
          );
  }
}
