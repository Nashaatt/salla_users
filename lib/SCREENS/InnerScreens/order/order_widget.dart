import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/MODELS/order_model.dart';
import 'package:smart_shop/PROVIDERS/order_provider.dart';
import 'package:smart_shop/SCREENS/RatingScreen.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

import '../../../PROVIDERS/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key, required this.orderModelAdvanced});
  final OrderModelAdvanced orderModelAdvanced;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  void initState() {
    print(widget.orderModelAdvanced.ImageUrl);
    super.initState();
  }

  bool seemore = false;
  @override
  Widget build(BuildContext context) {
    // final OrderModelAdvanced orderModelAdvanced;
    final orderProvider = Provider.of<OrderProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    getdate(String input) {
      DateTime parsedDate = DateTime.parse(input);

      String formattedDate =
          DateFormat.MMMd().format(parsedDate); // Formats as "Dec 30"
      String year =
          DateFormat.y().format(parsedDate); // Extracts the year as "2023"

      String finalFormattedDate = '$formattedDate $year'; // Combines both parts

      return finalFormattedDate; // Output: Dec 30 2023
    }

    return Column(
      children: [
        FittedBox(
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FancyShimmerImage(
                      imageUrl: widget.orderModelAdvanced.ImageUrl,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.8,
                              child: TitlesTextWidget(
                                label: widget.orderModelAdvanced.prductTitle,
                                maxLines: 2,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.clear,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SubtitleTextWidget(
                          label:
                              "Price : ${widget.orderModelAdvanced.price} AED",
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SubtitleTextWidget(
                          label: "Qty :${widget.orderModelAdvanced.quntity}",
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  seemore = !seemore;
                });
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: const SubtitleTextWidget(
                  color: Colors.blue,
                  label: "See more..",
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 20, 0),
              child: SubtitleTextWidget(
                color: Colors.blue,
                label: widget.orderModelAdvanced.orderStatus == "1"
                    ? "Shipping"
                    : widget.orderModelAdvanced.orderStatus == "2" ||
                            widget.orderModelAdvanced.orderStatus == "3"
                        ? "Delivered"
                        : "Preparing",
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        seemore == true
            ? Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 238, 203),
                    borderRadius: BorderRadius.circular(15)),
                width: size.width * 1,
                // height: size.height * .2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    SubtitleTextWidget(
                      label: "Name : ${userProvider.userModel!.userName}",
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SubtitleTextWidget(
                      label:
                          "Email Address : ${userProvider.userModel!.userEmail}",
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SubtitleTextWidget(
                      label:
                          "Address : ${widget.orderModelAdvanced.orderaddress}",
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SubtitleTextWidget(
                          label: "Payment Status :",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        SizedBox(width: 5),
                        SubtitleTextWidget(
                          color: Colors.purple,
                          label: "cash on delivery",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SubtitleTextWidget(
                          label: "delivery Status :",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        const SizedBox(width: 5),
                        SubtitleTextWidget(
                          color: Colors.green,
                          label: widget.orderModelAdvanced.orderStatus == "1"
                              ? "shipping"
                              : widget.orderModelAdvanced.orderStatus == "2" ||
                                      widget.orderModelAdvanced.orderStatus ==
                                          "3"
                                  ? "Delivered"
                                  : "preparing",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ],
                    ),
                    widget.orderModelAdvanced.orderStatus == "1"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SubtitleTextWidget(
                                color: Colors.red,
                                label: "Estimated Delivery Date :",
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              SubtitleTextWidget(
                                color: Colors.red,
                                label:
                                    "${getdate(widget.orderModelAdvanced.deliverydate.toString())}",
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ],
                          )
                        : widget.orderModelAdvanced.orderStatus == "2"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RatingScreen(
                                            widget.orderModelAdvanced.orderId,
                                            widget
                                                .orderModelAdvanced.productId)),
                                  );
                                },
                                child: const SubtitleTextWidget(
                                  color: Colors.blue,
                                  label: "Write Review",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              )
                            : widget.orderModelAdvanced.orderStatus == "3"
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_rounded,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                        SubtitleTextWidget(
                                          color: Colors.blue,
                                          label: "Review Added",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                  ],
                ),
              )
            : const SizedBox(),
//             RatingBar.builder(
//    initialRating: 3,
//    minRating: 1,
//    direction: Axis.horizontal,
//    allowHalfRating: true,
//    itemCount: 5,
//    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//    itemBuilder: (context, _) => Icon(
//      Icons.star,
//      color: Colors.amber,
//    ),
//    onRatingUpdate: (rating) {
//      print(rating);
//    },
// )
      ],
    );
  }
}
