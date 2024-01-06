import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/AUTH/forot_password_screen.dart';
import 'package:smart_shop/AUTH/login.dart';
import 'package:smart_shop/AUTH/register.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/order_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/rating_provider.dart';
import 'package:smart_shop/PROVIDERS/theme_provider.dart';
import 'package:smart_shop/PROVIDERS/user_provider.dart';
import 'package:smart_shop/PROVIDERS/viewed_product_provider.dart';
import 'package:smart_shop/PROVIDERS/wishList_provider.dart';
import 'package:smart_shop/SCREENS/home_screen.dart';
import 'package:smart_shop/SCREENS/search_screen.dart';
import 'package:smart_shop/SIDE%20SCREENS/AddAddressScreen.dart';
import 'package:smart_shop/SIDE%20SCREENS/order_screen.dart';
import 'package:smart_shop/SIDE%20SCREENS/product_datails_screen.dart';
import 'package:smart_shop/SIDE%20SCREENS/viewed_Recent_Screen.dart';
import 'package:smart_shop/SIDE%20SCREENS/wislist_screen.dart';
import 'package:smart_shop/firebase_options.dart';
import 'package:smart_shop/root_screen.dart';

import 'CONSTANTS/theme_data.dart';
import 'PROVIDERS/address_provider.dart';

void main() {
  //////////////////////////////////////////////////////
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              details.exception.toString(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
          ],
        ),
      ),
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SelectableText(
                snapshot.error.toString(),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                return ThemeProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return ProductProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return CartProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return WishListProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return ViewedProductProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return UserProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return OrderProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return AddressProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return RatingProvider();
              },
            ),
          ],
          child:
              Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'SALLA',
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(
                isDarkTheme: themeProvider.getIsDarkTheme,
                context: context,
              ),
              home: const RegisterScreen(), //// start  \\\\\
              routes: {
                RootScreen.routeName: (context) => const RootScreen(),
                ProductDetailsScreen.routName: (context) =>
                    const ProductDetailsScreen(),
                WishListScreen.routName: (context) => const WishListScreen(),
                ViewedRecentScreen.routName: (context) =>
                    const ViewedRecentScreen(),
                RegisterScreen.routName: (context) => const RegisterScreen(),
                LoginScreen.routName: (context) => const LoginScreen(),
                OrdersScreenFree.routeName: (context) =>
                    const OrdersScreenFree(),
                ForgotPasswordScreen.routeName: (context) =>
                    const ForgotPasswordScreen(),
                SearchScreen.routName: (context) => const SearchScreen(),
                HomePage.routName: (context) => const HomePage(),
                AddressEditScreen.routName: (context) =>
                    const AddressEditScreen(),
              },
            );
          }),
        );
      },
    );
  }
}
