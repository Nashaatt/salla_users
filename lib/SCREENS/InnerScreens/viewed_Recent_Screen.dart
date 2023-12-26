import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/viewed_product_provider.dart';
import 'package:smart_shop/WIDGETS/empty_bag_widget.dart';
import 'package:smart_shop/WIDGETS/product_widget.dart';

import '../../CONSTANTS/app_colors.dart';


class ViewedRecentScreen extends StatelessWidget {
  const ViewedRecentScreen({super.key});
  static const routName = "/ViewedRecentScreen";
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final viwedProductProvider = Provider.of<ViewedProductProvider>(context);
    return viwedProductProvider.getViewedProductItems.isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              image: "IMG/bag/emptyCart.png",
              title: "No viewed products",
              subTitle: "what are you waiting for ? browse some products",
              buttonTitle: "View Products",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              // leading: const Icon(
              //   Icons.arrow_left_outlined,
              //   color: AppColors.goldenColor,
              // ),
              title: Text(
                "Viewied Recently [ ${viwedProductProvider.getViewedProductItems.length} ] Products",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      viwedProductProvider.clearLocalViewedProduct();
                    },
                    icon: const Icon(
                      Icons.clear_all,
                      color: AppColors.goldenColor,
                    ))
              ],
            ),
            body: DynamicHeightGridView(
              physics: const BouncingScrollPhysics(),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ProductWidget(
                    productId: viwedProductProvider.getViewedProductItems.values
                        .toList()[index]
                        .producttID,
                  ),
                );
              },
              itemCount: viwedProductProvider.getViewedProductItems.length,
              crossAxisCount: 3,
            ),
          );
  }
}
