import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/MODELS/cart_model.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/WIDGETS/qty_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

import '../../PROVIDERS/cart_provider.dart';

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
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Slidable(
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (v) async {
                      await cartProvider.removeCartItemFromFirestor(
                        context: context,
                        cartId: cartModel.cartID,
                        productId: cartModel.producttID,
                        qty: cartModel.cartQty,
                      );
                      cartProvider.removeOneItem(
                        productId: getCurrentProduct.productID,
                      );
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ]),
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///
                          Column(
                            children: [
                              ////////////////////////////  IMAGE   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: FancyShimmerImage(
                                  imageUrl: getCurrentProduct.productImage,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ////////////////////////////  QTY   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                              SizedBox(
                                height: 30,
                                width: 90,
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
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
                                    // color: Colors.black,
                                    size: 15,
                                  ),
                                  label: Text(
                                    // getCurrentProduct.productQty
                                    "${cartModel.cartQty}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      width: 1,
                                      color: AppColors.goldenColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            width: 20,
                          ),
                          //////////////////////////////TITLE//////////////////////////////////

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .55,
                                child: TitlesTextWidget(
                                  label: getCurrentProduct.productTitle,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              SizedBox(
                                width: MediaQuery.of(context).size.width * .55,
                                child: TitlesTextWidget(
                                  label: getCurrentProduct.productDescreption,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 2,
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              ////////////////////////////////PRICE????????????????????????????
                              Row(
                                children: [
                                  const SubtitleTextWidget(
                                    label: "AED",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SubtitleTextWidget(
                                    label: " ${getCurrentProduct.productPrice}",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              ////////////////////////////Only on Stock
                              TitlesTextWidget(
                                label:
                                    "Only ${getCurrentProduct.productQty} In Stock",
                                fontSize: 12,
                                color: AppColors.goldenColor,
                              ),

                              //////////////////////////////QTY\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
