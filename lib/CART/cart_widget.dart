import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/MODELS/cart_model.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/WIDGETS/quantity_bottum.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final productsProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productsProvider.findById(cartModel.producttID);
    final cartProvider = Provider.of<CartProvider>(context);
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 188, 188, 188),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ////////////////////////////  IMAGE   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                    ///
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.productImage,
                        height: 100,
                        width: 100,
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //////////////////////////////////Title\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                            SizedBox(
                              width: 140,
                              child: TitlesTextWidget(
                                label: getCurrentProduct.productTitle,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            /////////////////////////////////DELETE\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                            IconButton(
                              onPressed: () async {
                                await cartProvider.removeCartItemFromFirestor(
                                  cartId: cartModel.cartID,
                                  productId: cartModel.producttID,
                                  qty: cartModel.cartQty,
                                );
                                cartProvider.removeOneItem(
                                  productId: getCurrentProduct.productID,
                                );
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Color.fromARGB(255, 219, 43, 30),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        ////////////////////////////////PRICE????????????????????????????
                        SubtitleTextWidget(
                          label: "${getCurrentProduct.productPrice} AED",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //////////////////////////////QTY\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                        SizedBox(
                          height: 23,
                          width: 70,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await showModalBottomSheet(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return QuentityBottomWidget(
                                      cartModel: cartModel,
                                    );
                                  });
                            },
                            icon: const Icon(
                              IconlyLight.arrowDown2,
                              color: Colors.black,
                              size: 15,
                            ),
                            label: Text(
                              // getCurrentProduct.productQty
                              "${cartModel.cartQty}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 2,
                                color: Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
