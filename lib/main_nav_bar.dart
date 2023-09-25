import 'package:ecommerce/controller/nav_bar_provider.dart';
import 'package:ecommerce/pages/cart/cart_screen.dart';
import 'package:ecommerce/pages/home/home.dart';
import 'package:ecommerce/utilits/fonts.dart';
import 'package:ecommerce/widgets/main_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainBar extends StatefulWidget {
  const MainBar({super.key});

  @override
  State<MainBar> createState() => _MainBarState();
}

class _MainBarState extends State<MainBar> {
  List<Widget> list = [
    HomeScreen(),
    CartItem(),
    Container(),
  ];
  AppFonts? appFonts;

  @override
  Widget build(BuildContext context) {
    appFonts = AppFonts(context: context);
    return Scaffold(
      bottomNavigationBar: BottomMainBarItem(appFonts: appFonts),
      body: list[Provider.of<NavBarProvider>(context).index],
    );
  }
}
