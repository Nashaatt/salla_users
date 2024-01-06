import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/viewed_product_provider.dart';

import '../../SIDE SCREENS/product_datails_screen.dart';

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
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.grey),
                // borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //////////////////   IMAGE  \\\\\\\\\\\\\\\\\\\\\\\\\
                    Stack(
                      children: [
                        Container(
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // color: Colors.white,
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FancyShimmerImage(
                                imageUrl: getCurrentProduct.productImage,
                              ),
                            ),
                          ),
                        ),

                        ////////////////////////////// Cart Button \\\\\\\\\\\\\\\\\\\\\\\\\\
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 2, color: Colors.blue),
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
                                  print(e.toString());
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

                        const SizedBox(
                          height: 20,
                        ),

                        /////////////////////////Price///////////////////////////////////////
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    ///////////////////End Of Big Column\\\\\\\\\\\\\\\\\\
                  ],
                ),
              ),
            ),
          );
  }
}
