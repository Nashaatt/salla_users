import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/PROVIDERS/theme_provider.dart';
import 'package:smart_shop/PROVIDERS/wishList_provider.dart';
import 'package:smart_shop/SCREENS/cart_screen.dart';
import 'package:smart_shop/SIDE%20SCREENS/wislist_screen.dart';
import 'package:smart_shop/WIDGETS/ITEM%20WIDGETS/Latest_Arrival.dart';
import 'package:smart_shop/WIDGETS/category_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

import '../CONSTANTS/app_constans.dart';

class HomePage extends StatelessWidget {
  static const routName = "/HomePage";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 50,
        title: const AppNameTextWidget(
          text: "SALLA",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const WishListScreen())));
                },
                child: Badge(
                    label: TitlesTextWidget(
                      label: "${wishListProvider.getWishListItems.length}",
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    child: const Icon(CupertinoIcons.heart))),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CartScreen())));
                },
                child: Badge(
                    label: TitlesTextWidget(
                      label: "${cartProvider.getCartItems.length}",
                      color: Colors.white,
                      fontSize: 11,
                    ),
                    child: const Icon(CupertinoIcons.cart))),
          )
        ],
      ),
      ///////////////////////////////////  B O D Y \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///////////////////////////////////// BANNERS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            SizedBox(
              height: size.height * 0.4,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    width: double.infinity,
                    height: size.height * 0.20,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Image.network(
                        AppConsts.bannerImages[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                itemCount: AppConsts.bannerImages.length,
                autoplay: true,
              ),
            ),

            ///////////////////  CATEGORIES  //////////////////////

            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: SizedBox(
                height: size.height * 0.20,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: AppConsts.categoryList.length,
                    itemBuilder: (context, index) {
                      return CategoryRoundedWidget(
                        image: AppConsts.categoryList[index].image,
                        name: AppConsts.categoryList[index].name,
                      );
                    }),
              ),
            ),

            ////////////////////////////////////////////////////////////////////
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: productsProvider.getProductproductsHorizontal.isNotEmpty,
              child: const CustomizeListName(text: "New Arrival ' S"),
            ),
            const SizedBox(
              height: 15,
            ),

            ////////////////////////////////////////////////////////////////////
            ///

            Visibility(
              visible: productsProvider.getProductproductsHorizontal.isNotEmpty,
              child: SizedBox(
                height: 325,
                width: double.infinity,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: productsProvider
                                .getProductproductsHorizontal.length <
                            10
                        ? productsProvider.getProductproductsHorizontal.length
                        : 10,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: productsProvider
                              .getProductproductsHorizontal[index],
                          child: const LatestArrivalProductWidget());
                    }),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //////////////////////////  Latest Arrival   ///////////////////////

            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: productsProvider.getProductproductsHorizontal.isNotEmpty,
              child: const CustomizeListName(text: "Latest Arrival ' S"),
            ),
            const SizedBox(
              height: 15,
            ),

            ////////////////////////////////////////////////////////////////////

            Visibility(
              visible:
                  productsProvider.productsproductsSecondHorizontal.isNotEmpty,
              child: SizedBox(
                height: 325,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: productsProvider
                              .productsproductsSecondHorizontal.length <
                          10
                      ? productsProvider.productsproductsSecondHorizontal.length
                      : 10,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: productsProvider
                          .productsproductsSecondHorizontal[index],
                      child: const LatestArrivalProductWidget(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ////////////////      Recommended For You      //////////////////////

            Visibility(
              visible: productsProvider.getproductsproductsVertical.isNotEmpty,
              child: Container(
                color: Colors.green.shade200,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///// List Name
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: CustomizeListName(text: "Recommended For You"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //// Grid view
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3.8,
                      ),
                      itemCount: productsProvider
                                  .getproductsproductsVertical.length <
                              10
                          ? productsProvider.getproductsproductsVertical.length
                          : 10,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: productsProvider
                              .getproductsproductsVertical[index],
                          child: const LatestArrivalProductWidget(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /////////////////////////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
}

////////////////////////////////  Customize List Name  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///

class CustomizeListName extends StatelessWidget {
  const CustomizeListName({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      child: TitlesTextWidget(
        label: text,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
