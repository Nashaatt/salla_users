import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

import '../../CONSTANTS/app_colors.dart';

class MainProduct extends StatelessWidget {
  const MainProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.45,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: const Color.fromARGB(199, 160, 155, 155),
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
                          imageUrl:
                              "https://www.sportsdirect.com/images/products/37896908_l.jpg",
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
                      child: const Icon(IconlyLight.heart),
                    ),
                  ),
                ],
              ),
              //////////////////////////////////////////////////////////////////////////
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubtitleTextWidget(
                    label: "Product Name",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TitlesTextWidget(
                    label:
                        "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwllllllllllllllllllllllllllllllllllllllllllllllll",
                    maxLines: 3,
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ],
              ),

              ////////////////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitlesTextWidget(
                    label: "1000 AED",
                    maxLines: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.white,
                  ),
                  /////////////////////////

                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 3,
                      // ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
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
