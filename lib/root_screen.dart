import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/CART/cart_screen.dart';
import 'package:smart_shop/PROVIDERS/address_provider.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/theme_provider.dart';
import 'package:smart_shop/PROVIDERS/user_provider.dart';
import 'package:smart_shop/PROVIDERS/wishList_provider.dart';

import 'SCREENS/home_screen.dart';
import 'SCREENS/profile_screen.dart';
import 'SCREENS/search_screen.dart';


class RootScreen extends StatefulWidget {
  static const routeName = "/RootScreen";
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  bool isLoadingProd = true;
  @override
  void initState() {
    super.initState();
    screens = const [
      HomePage(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchFCT() async {
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    final wishListProvider =
        Provider.of<WishListProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Future.wait({
        productsProvider.fetchProducts(),
        productsProvider.fetchProductsHorizontal(),
        productsProvider.fetchProductsVertical(),
        userProvider.fetchUserInfo(),
      });
      Future.wait({
        cartProvider.fetchCart(),
      });
      Future.wait({
        addressProvider.fetchAddress(),
      });
      Future.wait({
        wishListProvider.fetchWishList(),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoadingProd) {
      fetchFCT();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: GNav(
        curve: Curves.easeIn,
        tabBorderRadius: 25,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: currentScreen,
        hoverColor: Color(0xffCBB26A),
        activeColor: Color(0xffCBB26A),
        color: themeProvider.getIsDarkTheme ? Colors.white38 : Colors.black38,
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
        tabs: const [
          GButton(
            icon: Icons.star,
          ),
          GButton(
            icon: Icons.search,
          ),
          GButton(
            icon: Icons.shopping_cart,
          ),
          GButton(
            icon: Icons.person,
          ),
        ],
        onTabChange: (index) {
          setState(() {
            currentScreen = index;
          });

          controller.jumpToPage(currentScreen);
        },
      ),
    );
  }
}
