import 'package:ecommerce/controller/api/get_products.dart';
import 'package:ecommerce/controller/api/product_operation.dart';
import 'package:ecommerce/controller/api_provider.dart';
import 'package:ecommerce/controller/card_provider_product.dart';
import 'package:ecommerce/controller/cart_index_provider.dart';
import 'package:ecommerce/controller/nav_bar_provider.dart';
import 'package:ecommerce/pages/auth/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'main_nav_bar.dart';

late final SharedPreferences sharedPreferences;
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Future.delayed(Duration(seconds: 4), () {
    FlutterNativeSplash.remove();
  });
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSpalsh = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavBarProvider>(create: (_) => NavBarProvider()),
        ChangeNotifierProvider<IndexProvider>(create: (_) => IndexProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
        ChangeNotifierProvider<ApiProvider>(create: (_) => ApiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
