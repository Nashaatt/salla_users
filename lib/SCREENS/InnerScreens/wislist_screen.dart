import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/wishList_provider.dart';
import 'package:smart_shop/WIDGETS/empty_bag_widget.dart';
import 'package:smart_shop/WIDGETS/product_widget.dart';

import '../../CONSTANTS/app_colors.dart';
import '../../WIDGETS/app_name.dart';

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
            // appBar: AppBar(
            //   centerTitle: true,
            //   leading: const Icon(
            //     Icons.arrow_back_ios,
            //     color: AppColors.goldenColor,
            //   ),
            //   title: Text(
            //     "WishList  [ ${wishListProvider.getWishListItems.length} ]  Products",
            //     style: const TextStyle(
            //       fontSize: 13,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   actions: [
            //     IconButton(
            //         onPressed: () async {
            //           await wishListProvider.clearWishListFromFirestore();
            //           wishListProvider.clearLocalWishList();
            //         },
            //         icon: const Icon(
            //           Icons.clear_all,
            //           color: AppColors.goldenColor,
            //         ))
            //   ],
            // ),
            body: Column(
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
                            "WishList  [ ${wishListProvider.getWishListItems.length} ]  Products",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
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
                ),
                Expanded(
                  child: DynamicHeightGridView(
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
                ),
              ],
            ),
          );
  }
}
