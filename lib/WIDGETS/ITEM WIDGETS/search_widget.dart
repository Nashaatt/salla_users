import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/viewed_product_provider.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

import '../../SIDE SCREENS/product_datails_screen.dart';

class SearchWidget extends StatefulWidget {
  final String productId;

  const SearchWidget({
    super.key,
    required this.productId,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentProduct = productsProvider.findById(widget.productId);
    final viwedProductProvider = Provider.of<ViewedProductProvider>(context);
    Size size = MediaQuery.of(context).size;

    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () async {
              viwedProductProvider.addViewedProduct(
                productId: getCurrentProduct.productID,
              );
              await Navigator.pushNamed(
                context,
                ProductDetailsScreen.routName,
                arguments: getCurrentProduct.productID,
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //////////////////IMAGE\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                Container(
                  width: 80,
                  height: 80,
                  child: FancyShimmerImage(
                    imageUrl: getCurrentProduct.productImage,
                    // width: double.infinity,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                //////////////////////PRODUCT TITLE\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitlesTextWidget(
                        label: getCurrentProduct.productTitle,
                        fontWeight: FontWeight.bold,
                        maxLines: 2,
                        fontSize: 13,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ///////////////////////////PRICE////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubtitleTextWidget(
                            label: "${getCurrentProduct.productPrice} AED",
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          ////////////////////////////////////
                          TitlesTextWidget(
                            label: getCurrentProduct.productcategory,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /////////////////// End Of Big Column \\\\\\\\\\\\\\\\\\
              ],
            ),
          );
  }
}
