import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/PROVIDERS/address_provider.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/theme_provider.dart';
import 'package:smart_shop/PROVIDERS/user_provider.dart';
import 'package:smart_shop/PROVIDERS/wishList_provider.dart';
import 'package:smart_shop/SCREENS/cart_screen.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

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
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final wishListProvider =
        Provider.of<WishListProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Future.wait({
        productsProvider.fetchProducts(),
        productsProvider.fetchProductsHorizontal(),
        productsProvider.fetchProductsSecondHorizontal(),
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
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      //////////////////// themeProvider.getIsDarkTheme ? Colors.white : Colors.black //////////////////////////////
      bottomNavigationBar: CurvedNavigationBar(
        height: 52,
        buttonBackgroundColor: AppColors.goldenColor,
        animationCurve: Curves.easeIn,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: const Color.fromARGB(255, 16, 60, 16),
        index: currentScreen,
        onTap: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        items: [
          const Icon(
            Icons.home,
            color: Colors.white,
          ),
          const Icon(
            Icons.search,
            color: Colors.white,
          ),
          Badge(
            label: TitlesTextWidget(
              label: "${cartProvider.getCartItems.length}",
              fontSize: 9,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
