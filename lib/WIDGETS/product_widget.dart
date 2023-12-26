import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/viewed_product_provider.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/WIDGETS/heart_Btn.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

import '../SCREENS/InnerScreens/product_datails_screen.dart';


class ProductWidget extends StatefulWidget {
  final String productId;

  const ProductWidget({
    super.key,
    required this.productId,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                color: Color.fromARGB(199, 160, 155, 155),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //////////////////IMAGE\\\\\\\\\\\\\\\\\\\\\\\\\
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FancyShimmerImage(
                                imageUrl: getCurrentProduct.productImage,
                                // width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        //////////////////////////////Heart Button \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: HeartButton(
                              productID: getCurrentProduct.productID,
                            ),
                          ),
                        ),
                        //////////////////////////////Cart Button \\\\\\\\\\\\\\\\\\\\\\\\\\
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () async {
                                if (cartProvider.isProdInCart(
                                    productId: getCurrentProduct.productID)) {
                                  return;
                                }
                                cartProvider.addProductToCart(
                                    productId: getCurrentProduct.productID);

                                try {
                                  await cartProvider.addToCartFirebase(
                                    productId: getCurrentProduct.productID,
                                    qty: 1,
                                    context: context,
                                  );
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  MyAppFunctions.showErrorOrWarningDialog(
                                      context: context,
                                      subtitle: e.toString(),
                                      fct: () {});
                                }
                              },
                              child: Icon(
                                cartProvider.isProdInCart(
                                        productId: getCurrentProduct.productID)
                                    ? Icons.check
                                    : Icons.add,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //////////////////////PRODUCT TITLE\\\\\\\\\\\\\\\\\\\\\\
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: TitlesTextWidget(
                            label: getCurrentProduct.productTitle,
                            fontWeight: FontWeight.normal,
                            maxLines: 2,
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ///////////////////////////PRICE////////////////////////////////////
                        FittedBox(
                          child: SubtitleTextWidget(
                            label: "${getCurrentProduct.productPrice} AED",
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    ///////////////////End Of Big Column\\\\\\\\\\\\\\\\\\
                  ],
                ),
              ),
            ),
          );
  }
}
