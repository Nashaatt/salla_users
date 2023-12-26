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
import 'package:smart_shop/SCREENS/InnerScreens/order/order_screen.dart';
import 'package:smart_shop/SCREENS/InnerScreens/product_datails_screen.dart';
import 'package:smart_shop/SCREENS/InnerScreens/viewed_Recent_Screen.dart';
import 'package:smart_shop/SCREENS/InnerScreens/wislist_screen.dart';
import 'package:smart_shop/SCREENS/search_screen.dart';
import 'package:smart_shop/WIDGETS/AddAddressScreen.dart';

import 'package:smart_shop/firebase_options.dart';
import 'package:smart_shop/root_screen.dart';

import 'CONSTANTS/theme_data.dart';
import 'PROVIDERS/address_provider.dart';
import 'SCREENS/splash_screen.dart';

void main() {
  //// Handling Error in hole Application \\\\\\\
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
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            ),ChangeNotifierProvider(
              create: (_) {
                return AddressProvider();
              },
            ),ChangeNotifierProvider(
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
              home: const SpalshScreen(), //// start  \\\\\
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
                AddressEditScreen.routName: (context) => const AddressEditScreen(),
              },
            );
          }),
        );
      },
    );
  }

  //SHA-1//D2:12:C6:10:4E:15:EE:30:CC:6E:AF:0C:AF:CE:F0:44:5C:21:04:85//
  //version '4.4.0' apply false
}
