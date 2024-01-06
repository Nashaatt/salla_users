import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/MODELS/rating_model.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/rating_provider.dart';
import 'package:smart_shop/WIDGETS/heart_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

import '../CONSTANTS/app_colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
  });
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
        toolbarHeight: 35,
        title: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: AppNameTextWidget(
            text: "SALLA",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                    InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(10),
                      maxScale: 5.0,
                      minScale: 0.001,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: FancyShimmerImage(
                          imageUrl: getCurrentProduct.productImage,
                          height: size.height * 0.45,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldenColor,
                          fontSize: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 129, 192, 129),
                            ),
                            child: HeartButton(
                              productID: getCurrentProduct.productID,
                              size: 35,
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          SizedBox(
                            width: 400,
                            height: 70,
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
                                  print(e.toString());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.goldenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              icon: Icon(
                                cartProvider.isProdInCart(
                                        productId: getCurrentProduct.productID)
                                    ? Icons.check
                                    : Icons.add_shopping_cart,
                                size: 30,
                              ),
                              label: Text(
                                cartProvider.isProdInCart(
                                        productId: getCurrentProduct.productID)
                                    ? "Succefully Added"
                                    : "Add To Cart",
                                style: const TextStyle(fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                              label: "Overview",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            TitlesTextWidget(
                              label: getCurrentProduct.productcategory,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColors.goldenColor,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          getCurrentProduct.productDescreption,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const Divider(
                          color: AppColors.goldenColor,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //////////////////////////// Reviews /////////////////////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitlesTextWidget(
                              label: "User Reviews",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            /////////////////////////Rating//////////////////////////
                            RatingBarIndicator(
                              rating:
                                  getCurrentProduct.productrating!.toDouble(),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              unratedColor: Colors.black,
                              itemCount: 5,
                              itemSize: 18.0,
                              direction: Axis.horizontal,
                            ),
                            ////////////////////////////////////////////////////////////
                          ],
                        ),
                        const Divider(
                          color: AppColors.goldenColor,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FutureBuilder<List<RatingModelAdvanced>>(
                          future: ratingProvider.fetchproductreview(productId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return SelectableText(
                                snapshot.error.toString(),
                              );
                            } else if (!snapshot.hasData ||
                                ratingProvider.getreviews.isEmpty) {}
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
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
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                /////////////////////Title Review/////////////////////////
                                                TitlesTextWidget(
                                                  label: review.titlereview
                                                      .toString(), // User name fetched based on userId
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                /////////////////////review/////////////////////////
                                                TitlesTextWidget(
                                                  label: review.review
                                                      .toString(), // User name fetched based on userId
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  maxLines: 3,
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
