import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/MODELS/rating_model.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/rating_provider.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/WIDGETS/app_name.dart';
import 'package:smart_shop/WIDGETS/heart_Btn.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

import '../../CONSTANTS/app_colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});
  static const routName = "/ProductDetailsScreen";

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    final ratingProvider = Provider.of<RatingProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrentProduct = productsProvider.findById(productId!);
    Size size = MediaQuery.of(context).size;
    double calculateHeightForItem(RatingModelAdvanced review) {
      double userRowHeight = 60.0;
      double reviewTextHeight = 50.0;
      double padding = 20.0;

      // Calculate the total height needed for an individual item
      double totalItemHeight = userRowHeight + reviewTextHeight + padding;

      return totalItemHeight;
    }

    return Scaffold(
      body: getCurrentProduct == null
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const AppNameTextWidget(
                      text: "SALLA",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.productImage,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            getCurrentProduct.productTitle,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SubtitleTextWidget(
                          label: "${getCurrentProduct.productPrice} AED",
                          fontWeight: FontWeight.normal,
                          color: AppColors.goldenColor,
                          fontSize: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100),
                            child: HeartButton(
                              productID: getCurrentProduct.productID,
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () async {
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
                                    fct: () {},
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: AppColors.goldenColor,
                              ),
                              icon: Icon(
                                cartProvider.isProdInCart(
                                        productId: getCurrentProduct.productID)
                                    ? Icons.check
                                    : Icons.add_shopping_cart,
                              ),
                              label: Text(
                                cartProvider.isProdInCart(
                                        productId: getCurrentProduct.productID)
                                    ? "Succefully Added"
                                    : "Add To Cart",
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitlesTextWidget(
                              label: "About this item",
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            TitlesTextWidget(
                              label: getCurrentProduct.productcategory,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              getCurrentProduct.productDescreption * 30,
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder<List<RatingModelAdvanced>>(
                          future: ratingProvider.fetchproductreview(productId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return SelectableText(
                                snapshot.error.toString(),
                              );
                            } else if (!snapshot.hasData ||
                                ratingProvider.getreviews.isEmpty) {
                              // return const EmptyBagWidget(
                              //   image: "IMG/empty_search.png",
                              //   buttonTitle: "shop now",
                              //   title: "Empty Orders",
                              //   subTitle: "select order and enjoy the quality",
                              // );
                            }
                            double totalListViewHeight = 0.0;
                            if (snapshot.hasData) {
                              for (var review in snapshot.data!) {
                                // Calculate height for each item in the ListView
                                // Add this height to the totalListViewHeight
                                // Modify this logic based on your item height calculation
                                totalListViewHeight +=
                                    calculateHeightForItem(review);
                              }
                            }

                            return Container(
                              height: totalListViewHeight,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (ctx, index) {
                                  final review = snapshot.data![index];
                                  final userDetails = ratingProvider
                                      .getUserDetails(review.userId);

                                  return FutureBuilder(
                                    future: userDetails,
                                    builder: (BuildContext context,
                                        AsyncSnapshot userSnapshot) {
                                      if (userSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (userSnapshot.hasError) {
                                        return Text(
                                            'Error: ${userSnapshot.error}');
                                      } else if (!userSnapshot.hasData) {
                                        return const SizedBox(); // Return an empty widget or handle as needed
                                      }

                                      final user = userSnapshot.data!;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(user[
                                                              "userImage"]), // User image fetched based on userId
                                                      radius: 20,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          user["userName"]
                                                              .toString(), // User name fetched based on userId
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        "${double.parse(review.rating)}"),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    const Icon(
                                                      Icons.star,
                                                      color:
                                                          AppColors.goldenColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Wrap(
                                              children: [
                                                Container(
                                                  width: size.width * 3,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          45, 0, 0, 0),
                                                  child: Text(
                                                    review.review
                                                        .toString(), // User name fetched based on userId
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            // Other review components (rating, review text) here...
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    endIndent: 10,
                                    indent: 10,
                                    thickness: 1,
                                    color: AppColors.goldenColor,
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        // SubtitleTextWidget(
                        //   label: getCurrentProduct.productDescreption * 10,
                        //   fontSize: 8,
                        //   overflow: TextOverflow.visible,
                        //   color: Colors.grey,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
