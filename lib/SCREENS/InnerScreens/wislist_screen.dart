import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/wishList_provider.dart';
import 'package:smart_shop/WIDGETS/empty_bag_widget.dart';
import 'package:smart_shop/WIDGETS/product_widget.dart';

import '../../CONSTANTS/app_colors.dart';


class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  static const routName = "/WishListScreen";
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return wishListProvider.getWishListItems.isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              image: "IMG/bag/emptyCart.png",
              title: "Your Shopping cart looks empty.",
              subTitle: "what are you waiting for !!",
              buttonTitle: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.goldenColor,
              ),
              title: Text(
                "WishList  [ ${wishListProvider.getWishListItems.length} ]  Products",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      await wishListProvider.clearWishListFromFirestore();
                      wishListProvider.clearLocalWishList();
                    },
                    icon: const Icon(
                      Icons.clear_all,
                      color: AppColors.goldenColor,
                    ))
              ],
            ),
            body: DynamicHeightGridView(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ProductWidget(
                    productId: wishListProvider.getWishListItems.values
                        .toList()[index]
                        .producttID,
                  ),
                );
              },
              itemCount: wishListProvider.getWishListItems.length,
            ),
          );
  }
}
