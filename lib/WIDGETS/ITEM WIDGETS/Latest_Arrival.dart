import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/MODELS/product_model.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/viewed_product_provider.dart';
import 'package:smart_shop/SIDE%20SCREENS/product_datails_screen.dart';
import 'package:smart_shop/WIDGETS/heart_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

class LatestArrivalProductWidget extends StatelessWidget {
  const LatestArrivalProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    ///
    final viwedProductProvider = Provider.of<ViewedProductProvider>(context);

    return GestureDetector(
      onTap: () async {
        viwedProductProvider.addViewedProduct(
          productId: productModel.productID,
        );
        await Navigator.pushNamed(
          context,
          ProductDetailsScreen.routName,
          arguments: productModel.productID,
        );
      },
      child: Container(
        width: 165,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),

        ///////////////////////////////////////  IMAGE  //////////////////////////////////////////////////
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FancyShimmerImage(
                          imageUrl: productModel.productImage,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Visibility(
                        visible: productModel.productOldPrice!.isNotEmpty,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            color: AppColors.goldenColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          child: const TitlesTextWidget(
                            label: "OFFER 20 %",
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /////////////////////////////  TITLE AND DEScription  //////////////////////////////////////////////////

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SubtitleTextWidget(
                        label: productModel.productTitle,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 23,
                      child: TitlesTextWidget(
                        label: productModel.productDescreption,
                        maxLines: 2,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                /////////////////////////////////RATING///////////////////////////////////////////////////

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBarIndicator(
                      rating: productModel.productrating!.toDouble(),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.green,
                      ),
                      unratedColor: Colors.black,
                      itemCount: 5,
                      itemSize: 18.0,
                      direction: Axis.horizontal,
                    ),

                    //////////////////////////////////////////////Heart Button/////////////////////////////////
                    Flexible(
                      child: HeartButton(
                        productID: productModel.productID,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                //////////////////////////////PRICE AND CART//////////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const TitlesTextWidget(
                              label: "AED",
                              maxLines: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TitlesTextWidget(
                              label: "${productModel.productPrice} ",
                              maxLines: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        /////////////impelment//////////////////////
                        Text(
                          productModel.productOldPrice == null
                              ? ""
                              : productModel.productOldPrice.toString(),
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    //////////////////////////////////      CART      ////////////////////////////////////////////////////

                    InkWell(
                      child: SizedBox(
                          width: 28,
                          height: 28,
                          child: Icon(
                            cartProvider.isProdInCart(
                                    productId: productModel.productID)
                                ? Icons.check
                                : Icons.add_shopping_cart,
                            color: Colors.black,
                          )),
                      onTap: () async {
                        if (cartProvider.isProdInCart(
                            productId: productModel.productID)) {
                          return;
                        }
                        cartProvider.addProductToCart(
                            productId: productModel.productID);
                        try {
                          await cartProvider.addToCartFirebase(
                            productId: productModel.productID,
                            qty: 1,
                            context: context,
                          );
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          print(e.toString());
                        }
                      },
                    )
                  ],
                ),
                /////////////////////////////////////////////       Only on Stock       //////////////////////////////////////////////////
                TitlesTextWidget(
                  label: "Only ${productModel.productQty} In Stock",
                  fontSize: 12,
                  color: AppColors.goldenColor,
                ),

                ///////////////////////////////////////////                             //////////////////////////////////////////////////
              ],
            ),
          ],
        ),
      ),
    );
  }
}
