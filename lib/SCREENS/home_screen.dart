import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/products_provider.dart';
import 'package:smart_shop/WIDGETS/Latest_Arrival.dart';
import 'package:smart_shop/WIDGETS/app_name.dart';
import 'package:smart_shop/WIDGETS/category_Rounded_Widget.dart';
import 'package:smart_shop/WIDGETS/main_products.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

import '../CONSTANTS/app_constans.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),

              const AppNameTextWidget(
                text: "SALLA",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),

              const SizedBox(
                height: 20,
              ),

              /////////////////////////////////////BANNERS//////\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////
              SizedBox(
                height: size.height * 0.23,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        AppConsts.bannerImages[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  itemCount: AppConsts.bannerImages.length,
                  autoplay: true,
                ),
              ),
              //////////////////////////////////
              const SizedBox(
                height: 15,
              ),
              ////////////CATEGORIES NAME /////////////////
              const TitlesTextWidget(
                label: "Categories",
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 15,
              ),
              ////////////////////////////////////////////

              SizedBox(
                height: size.height * 0.14,
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

              ///////////////////////////////////////
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible:
                    productsProvider.getProductproductsHorizontal.isNotEmpty,
                child: const TitlesTextWidget(
                  label: "Latest Arrival",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              /////////////////////////////////////
              ///

              Visibility(
                visible:
                    productsProvider.getProductproductsHorizontal.isNotEmpty,
                child: SizedBox(
                  height: 340,
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
                            child: LatestArrivalProductWidget());
                      }),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ////////////Latest Arrival ///////////////////
              ///////////////////////////////////////
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible:
                    productsProvider.getProductproductsHorizontal.isNotEmpty,
                child: const TitlesTextWidget(
                  label: "Latest Arrival",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              /////////////////////////////////////

              Visibility(
                visible: productsProvider
                    .productsproductsSecondHorizontal.isNotEmpty,
                child: SizedBox(
                  height: 340,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: productsProvider
                                .productsproductsSecondHorizontal.length <
                            10
                        ? productsProvider
                            .productsproductsSecondHorizontal.length
                        : 10,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: productsProvider
                            .productsproductsSecondHorizontal[index],
                        child: LatestArrivalProductWidget(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ////////////CATEGORIES NAME /////////////////
              const TitlesTextWidget(
                label: "Recommanded ",
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 15,
              ),

              Visibility(
                visible:
                    productsProvider.getproductsproductsVertical.isNotEmpty,
                child: SizedBox(
                  width: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3.3,
                    ),
                    itemCount:
                        productsProvider.getproductsproductsVertical.length < 10
                            ? productsProvider
                                .getproductsproductsVertical.length
                            : 10,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: productsProvider
                              .getproductsproductsVertical[index],
                          child: LatestArrivalProductWidget());
                    },
                  ),
                ),
              ),

              ///////////////////////////////////////

              /////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}
