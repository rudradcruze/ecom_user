import 'package:ecom_user/pages/cart_page.dart';
import 'package:ecom_user/pages/checkout_page.dart';
import 'package:ecom_user/pages/launcher_page.dart';
import 'package:ecom_user/pages/login_page.dart';
import 'package:ecom_user/pages/order_successful_page.dart';
import 'package:ecom_user/pages/register_page.dart';
import 'package:ecom_user/pages/view_product_page.dart';
import 'package:ecom_user/pages/welcome_page.dart';
import 'package:ecom_user/providers/cart_provider.dart';
import 'package:ecom_user/providers/order_provider.dart';
import 'package:ecom_user/providers/product_provider.dart';
import 'package:ecom_user/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic("Weather");
  FirebaseMessaging.instance.subscribeToTopic("News");
  FirebaseMessaging.instance.subscribeToTopic("Friend Request");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        WelcomePage.routeName: (context) => const WelcomePage(),
        ViewProductPage.routeName: (context) => const ViewProductPage(),
        RegistrationPage.routeName: (context) => const RegistrationPage(),
        CartPage.routeName: (context) => const CartPage(),
        CheckoutPage.routeName: (context) => const CheckoutPage(),
        OrderSuccessfulPage.routeName: (context) => const OrderSuccessfulPage(),
      },
    );
  }
}