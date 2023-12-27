import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/CART/cart_widget.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/user_provider.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/WIDGETS/app_name.dart';
import 'package:smart_shop/WIDGETS/bottom_checkout.dart';
import 'package:smart_shop/WIDGETS/empty_bag_widget.dart';
import 'package:smart_shop/WIDGETS/loading_manager.dart';

import 'package:uuid/uuid.dart';

import '../CONSTANTS/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return cartProvider.getCartItems.isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              image: "IMG/bag/emptyCart.png",
              title: "Your Shopping cart looks empty.",
              subTitle: "what are you waiting for !!",
              buttonTitle: "Shop Now",
            ),
          )
        : Scaffold(
            body: LoadingManager(
              isLoading: isLoading,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppNameTextWidget(
                          text:
                              "Cart   [ ${cartProvider.getCartItems.length} ]   Products",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        IconButton(
                          onPressed: () async {
                            await cartProvider.clearCartFromFirestore();
                            cartProvider.clearLocalCart();
                          },
                          icon: const Icon(
                            Icons.clear_all,
                            color: AppColors.goldenColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartProvider.getCartItems.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: cartProvider.getCartItems.values
                                .toList()[index],
                            child: const CartWidget(),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: kBottomNavigationBarHeight + 10,
                  ),
                ],
              ),
            ),
            bottomSheet: CartBottomSheetWidget()
            //   function: () async {
            //   await orderPlace(
            //     cartProvider: cartProvider,
            //     productProvider: productProvider,
            //     userProvider: userProvider,
            //   );
            // }),
            );
  }

//////////////// Order Method /////////////////////
}
