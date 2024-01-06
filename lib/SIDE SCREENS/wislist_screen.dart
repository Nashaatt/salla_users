import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/wishList_provider.dart';
import 'package:smart_shop/WIDGETS/ITEM%20WIDGETS/product_widget.dart';
import 'package:smart_shop/WIDGETS/empty_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

import '../CONSTANTS/app_colors.dart';

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
              title: "Your WishList looks empty.",
              subTitle: "what are you waiting for !!",
              buttonTitle: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColors.goldenColor,
                  )),
              centerTitle: true,
              title: AppNameTextWidget(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                text: "[ ${wishListProvider.getWishListItems.length} ] Items",
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      wishListProvider.clearLocalWishList();
                    },
                    icon: const Icon(
                      Icons.clear_all,
                      color: AppColors.goldenColor,
                    ))
              ],
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 30,
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
