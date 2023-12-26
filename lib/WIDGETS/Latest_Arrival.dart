import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/MODELS/product_model.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/viewed_product_provider.dart';
import 'package:smart_shop/SCREENS/InnerScreens/product_datails_screen.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/WIDGETS/heart_Btn.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

class LatestArrivalProductWidget extends StatelessWidget {
  const LatestArrivalProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
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
        width: 200,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Color.fromARGB(199, 160, 155, 155),
          border: Border.all(
            color: AppColors.goldenColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                        imageUrl: productModel.productImage,
                        // width: double.infinity,
                      ),
                    ),
                  ),
                ),
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
                      productID: productModel.productID,
                    ),
                  ),
                ),
              ],
            ),
            //////////////////////////////////////////////////////////////////////////
            const SizedBox(
              height: 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubtitleTextWidget(
                  label: productModel.productTitle,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 3,
                ),
                TitlesTextWidget(
                  label: "${productModel.productDescreption}",
                  maxLines: 3,
                  fontWeight: FontWeight.w500,
                  fontSize: 8,
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitlesTextWidget(
                  label: "${productModel.productPrice} AED",
                  maxLines: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white,
                ),
                /////////////////////////

                InkWell(
                  child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Icon(
                        cartProvider.isProdInCart(
                                productId: productModel.productID)
                            ? Icons.check
                            : Icons.add,
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
                      MyAppFunctions.showErrorOrWarningDialog(
                        context: context,
                        subtitle: e.toString(),
                        fct: () {},
                      );
                    }
                  },
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: RatingBarIndicator(
                rating: productModel.productrating!.toDouble(),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 18.0,
                direction: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}











// SizedBox(
//   width: 70,
//   child: ElevatedButton.icon(
//     onPressed: () async {
//       if (cartProvider.isProdInCart(
//           productId: productModel.productID)) {
//         return;
//       }
//       cartProvider.addProductToCart(
//           productId: productModel.productID);
//       try {
//         await cartProvider.addToCartFirebase(
//           productId: productModel.productID,
//           qty: 1,
//           context: context,
//         );
//       } catch (e) {
//         // ignore: use_build_context_synchronously
//         MyAppFunctions.showErrorOrWarningDialog(
//           context: context,
//           subtitle: e.toString(),
//           fct: () {},
//         );
//       }
//     },
//     style: ElevatedButton.styleFrom(
//       elevation: 10,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10)),
//       backgroundColor: AppColors.goldenColor,
//     ),
//     icon: Icon(
//       cartProvider.isProdInCart(
//               productId: productModel.productID)
//           ? Icons.check
//           : Icons.add_shopping_cart,
//     ),
//     label: Text(""),
//   ),
// ),
